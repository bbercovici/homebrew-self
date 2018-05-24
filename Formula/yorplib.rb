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
  url "https://github.com/bbercovici/YORPLib/archive/1.0.8.tar.gz"
  sha256 "d103f0c3a28a5731c913c0bac52c78b0b31baa015ec774114770baae56247867"


  option "with-gcc" => :recommended , "On Mac, will attempt to compile with gcc from the Cellar " 
  
  depends_on "cmake" => :build

  def install

    # Compile
    if build.with? "gcc"
      system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
    else
      system "cmake . -DBREW:BOOL=TRUE" 
    end

    system "make -j"


    # Create symlink to library
    lib.install "libYORPLib.dylib"
    include.install "include/YORPLib"
    share.install "share/YORPLib"
    prefix.install "Example/"


  end

end
