class Logic
  def initialize
    @num_fruits = 10
#    @location_fruits = Array.new(@num_fruits) {[rand(-1.0 .. 1.0), rand(-1.0 .. 1.0)]}
#    @fruits = Array.new(@num_fruits, :apple)
#    @fruits[rand(0..9)] = :banana
#    pp @fruits
#    @weights = [rand(-1.0 .. 1.0)] * 5
    @weights = [0.3606003870509211, 0.3606003870509211, 0.3606003870509211, 0.3606003870509211, 0.3606003870509211]
    @location_fruits = []
    @fruits = []
    @speed = 0.01

    read_result
    pp @location_fruits
    pp @fruits
    pp @weights
   end

  def read_result
# りんご、バナナの初期値(x、y)をファイルから読み込む
    tmp_x = []
    open("result01/x座標のリスト.txt","r") do |fp|
      fp.each do |l|
         tmp_x << l.chomp.to_i
      end
    end

    tmp_y = []
    open("result01/y座標のリスト.txt","r") do |fp|
      fp.each do |l|
        tmp_y << l.chomp.to_i
      end
    end

    @num_fruits.times do |i|
      @location_fruits << [tmp_x[i], tmp_y[i]]
    end

#　りんごかバナナかをファイルから読みこむ
    open("result01/フルーツのリスト(りんご_ 1、バナナ_-1).txt") do |fp|
      fp.each do |l|
        @fruits << l.chomp.to_i
      end
    end

  end

  def main
    100.times do
      pp logic
    end
  end

  def logic
    @num_fruits.times do |id_fruit|
# 第1層目
      if @weights[0] * @location_fruits[id_fruit][0]/240.0 + @weights[1] * @location_fruits[id_fruit][1]/180.0 + @weights[2] > 0
        expect_fruit = 1 # :apple
      else
        expect_fruit = -1 # :banana
      end

# 第2層目
      if @weights[3] * expect_fruit + @weights[4] > 0
        expect_fruit = 1
      else
        expect_fruit = -1
      end

# 勾配
      df = @fruits[id_fruit] - expect_fruit
#      if @fruits[id_fruit] == expect_fruit
#        df = 0
#      else
#        if @fruits[id_fruit] == :apple
#          df = 2
#        else
#          df = -2
#        end
#      end
    
# 学習、重みの計算
      @weights[0] += @speed * df * @location_fruits[id_fruit][0]
      @weights[1] += @speed * df * @location_fruits[id_fruit][1]
      @weights[2] += @speed * df

      @weights[3] += @speed * df * expect_fruit
      @weights[4] += @speed * df

    end
    @weights

  end

end

Logic.new.main
