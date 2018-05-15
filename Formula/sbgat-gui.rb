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

class SbgatGui < Formula

  desc "Graphic User Interface of the Small Body Geophysical Analysis Tool"
  homepage "https://github.com/bbercovici/SBGAT"
  url "https://github.com/bbercovici/SBGAT/archive/1.05.1.tar.gz"
  sha256 "d5dc93477f8bc5c8ecde88e199ab670ff7ed1502afd0fa3d87ea259252ce5809"
    
  depends_on "cmake" 

  # Options
  option "with-gcc", "On Mac, will attempt to compile with gcc from the Cellar "

  def install

    # Compile and install SbgatGui
    Dir.chdir("SbgatGui/build") do
      
      if build.with? "gcc"
        system "cmake .. -DUSE_GCC:BOOL=TRUE" 
      else
        system "cmake .." 
      end 
      system "make -j"

      bin.install "SbgatGui"

    end



  end

end
