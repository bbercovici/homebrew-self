# MIT License

# Copyright (c) 2019 Benjamin Bercovici

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class Shapeuqlib < Formula
  desc "Implementation of an analytical small body shape uncertainty and inertia statistics formulation."
  homepage "https://github.com/bbercovici/ShapeUQLib"
  url "https://github.com/bbercovici/ShapeUQLib/archive/1.0.1.tar.gz"
  sha256 "5fbce6b916b7ffd90eb822c7a8ced2f090da7e646f48f9835bdf502a7704d7c5"

  depends_on "cmake" => :build
  depends_on "armadillo"
  depends_on "libomp" => :recommended
  
  def install

    # Compile
    if build.without?("libomp")
      system "cmake . -DBREW:BOOL=TRUE -DNO_OMP:BOOL=TRUE"  
    else
      system "cmake . -DBREW:BOOL=TRUE -DOpenMP_CXX_FLAGS='-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include' -DOpenMP_C_FLAGS='-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include' -DOpenMP_CXX_LIB_NAMES=omp -DOpenMP_C_LIB_NAMES=omp -DOpenMP_omp_LIBRARY=/usr/local/opt/libomp/lib/libomp.dylib"  
    end  
    system "make -j"

    # Create symlink to library
    lib.install "libShapeUQLib.dylib"
    include.install "include/ShapeUQLib"
    share.install "share/ShapeUQLib"

  end

end
