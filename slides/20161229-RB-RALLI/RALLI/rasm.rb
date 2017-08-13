#coding: utf-8
class Object
  #對一般物件無影響之自定義方法
  def to_var(_)
    return self
  end
end
class Rasm
  @@VERSION="1.2.01"
  #指令和程式的對應表格
  @@op=nil
  #用來表達變數的類別
  class Var
    attr_reader :name
    def initialize(name)
      @name=name
    end
    def hash
      @name.hash
    end
    #幫助Hash辨識相同的物件
    def eql?(o)
      o.hash==hash
    end
    #可以將變數轉換成物件
    def to_var(hash)
      hash[self]
    end
  end
  def initialize
    #變數列表
    @variables=Hash.new
    #指令列表
    @instructions=[]
    #跳轉表格
    @jmp_table=Hash.new
    #目前行數
    @line=0
    #尚未初始化執行環境則初始化
    @@op or init_instruct
  end
  #初始化執行環境
  def init_instruct
    @@op=Hash.new
    #將類別移到變數內
    @@op[:movc]=->(var,klass){
      @variables[var]=Kernel.const_get(klass)
    }
    #將變數搬移到另一變數
    @@op[:movr]=->(dst,src){
      @variables[dst]=@variables[src]
    }
    #將一個字面值搬移到變數
    @@op[:movi]=->(var,value){
      @variables[var]=value
    }
    #把var的變數存入src雜湊的[key]
    @@op[:save]=->(src,key,var){
      @variables[src][key]=@variables[var]
    }
    #進行方法呼叫並將結果存入to
    @@op[:call]=->(to,var,fun,*arg){
      @variables[to]=@variables[var].send(fun,*arg.map{|e| e.to_var(@variables)})
    }
    
    @@op[:puts]=->(var){
      puts @variables[var]
    }
    @@op[:p]=->(var){
      p @variables[var]
    }
    @@op[:print]=->(var){
      print @variables[var]
    }
    #假如a,b相同則跳到指定標籤
    @@op[:je]=->(a,b,dst){
      if @variables[a]==@variables[b]
        @line=@jmp_table[dst]
      end
    }
    #假如a,b不同則跳到指定標籤
    @@op[:jne]=->(a,b,dst){
      if @variables[a]!=@variables[b]
        @line=@jmp_table[dst]
      end
    }
    #直接跳到指定標籤
    @@op[:jmp]=->(dst){
      @line=@jmp_table[dst]
    }
  end
  #開始執行
  def run
    #有載入才動作
    @loaded and
    begin
      #目前行數小於總行數則繼續執行
      while @line<@instructions.size
        #取出動作和參數
        op,*arg=@instructions[@line]
        #執行該動作並往下個指令移動
        @@op[op].call(*arg)
        @line+=1
      end
    rescue =>e
      #檢查錯誤用的錯誤資訊列印
      p e
      print "error inst: "
      p @instructions[@line]
      return
    end
  end
  #載入字串作為程式碼
  def load(string)
    string.each_line{|line|
      #忽略空行
      line.chomp!
      line.strip!
      line.empty? and next
      
      #先看行首是否有標籤
      data=line.match(/(?<label>(#[A-Za-z]\w*))?(?<cmd>.*)?/)
      #設定該標籤所在位置
      label=data[:label] and @jmp_table[label]=@instructions.size-1
      #比對標籤後面是否有指令
      data=data[:cmd].match(/(?<opcode>\S+)?\s*(?<oprands>.*)?/)
      data[:opcode] or next
      
      #單行指令第一個元素為代表運算功能的符號
      inst=[data[:opcode].to_sym]
      #取得除了運算子外的運算元
      oprands=data[:oprands]
      #持續取出所有的運算元
      while oprands=oprands&.match(/\
((?<var>(\$[A-Za-z]\w*))|\
(?<float>([-+]?(0|([1-9]\d*))\.\d+))|\
(?<int>([-+]?(0|([1-9]\d*))))|\
(?<sym>(\:[^,]+))|\
(?<label>(\#[A-Za-z]\w+))|\
(?<string>(".*")))\
\s*(,\s*(?<others>.*))?/)
        case
        when v=oprands[:var]
          inst<<Var.new(v[1..-1].to_sym)
        when n=oprands[:int]
          inst<<n.to_i
        when f=oprands[:float]
          inst<<f.to_f
        when sym=oprands[:sym]
          inst<<sym[1..-1].to_sym
        when l=oprands[:label]
          inst<<l
        when str=oprands[:string]
          inst<<str[1..-2]
        end
        #記得拿出剩下沒比對的部份繼續比對
        oprands=oprands[:others]
      end
      #將完成的指令放入指令列表
      @instructions<<inst
    }
    @loaded = true
  end
end