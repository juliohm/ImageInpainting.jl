@testset "Crimisini" begin
  # diagonal pattern
  img  = [i + j > 10 ? 0.1 : 0.2 for i in 1:10, j in 1:10]
  mask = [1.2cos(i) + i > j for i in 1:10, j in 1:10]
  out  = inpaint(img, mask, Criminisi(5,5))
  @test_reference "data/diagonal.txt" out

  # cross pattern
  img = zeros(50,50) .+ 0.5
  for i in 1:50
    img[i,i] = 1.0
    img[i,50-i+1] = 1.0
  end
  mask = falses(size(img))
  mask[20:30,15:40] .= true
  out = inpaint(img, mask, Criminisi(9,9))
  @test_reference "data/cross.txt" out

  # blobs pattern
  img  = Float64.(Gray.(testimage("blobs")))
  mask = falses(size(img))
  mask[50:150,50:150] .= true
  out = inpaint(img, mask, Criminisi(11,11))
  @test_reference "data/blobs.png" out

  # lighthouse image
  img  = Float64.(Gray.(testimage("lighthouse")))
  mask = falses(size(img))
  mask[50:350,300:400] .= true
  out = inpaint(img, mask, Criminisi(30,30))
  @test_reference "data/lighthouse.png" out
end
