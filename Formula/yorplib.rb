# yorplib.rb
# MIT License

# Copyright (c) 2018 Benjamin Bercovici

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

class Yorplib < Formula
  desc "A library for the computation of the Fourier decomposition of YORP forces and moments"
  homepage "https://github.com/bbercovici/YORPLib"
  url "https://github.com/bbercovici/YORPLib/archive/1.0.10.tar.gz"
  sha256 "40bbf772eda91e82392d32849c6c4e6877cc0db9d308a4db18c9c0e69e8d98ec"


  depends_on "cmake"
  depends_on "libomp" => :recommended

  def install

    # Compile
    if build.without?("libomp")
      system "cmake . -DBREW:BOOL=TRUE"  
    else
      system "cmake . -DBREW:BOOL=TRUE -DOpenMP_CXX_FLAGS='-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include' -DOpenMP_C_FLAGS='-Xpreprocessor -fopenmp -I/usr/local/opt/libomp/include' -DOpenMP_CXX_LIB_NAMES=omp -DOpenMP_C_LIB_NAMES=omp -DOpenMP_omp_LIBRARY=/usr/local/opt/libomp/lib/libomp.dylib"  
    end   
    
    system "make -j"

    # Create symlink to library
    lib.install "libYORPLib.dylib"
    include.install "include/YORPLib"
    share.install "share/YORPLib"
    prefix.install "Example/"

  end

end
