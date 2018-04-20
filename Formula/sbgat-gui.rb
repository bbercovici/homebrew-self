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

  desc "Graphic User Interface to the Small Body Geophysical Analysis Tool"
  homepage "https://github.com/bbercovici/SBGAT"
  url "https://github.com/bbercovici/SBGAT/archive/1.04.6.tar.gz"
  sha256 "7cf5e4995464028680a7ca97436f763807b3964ccfaae11fb6c8e9702f747f6a"
  
  # Options
  option "with-gcc", "On Mac, will attempt to compile with gcc from the Cellar "

  def install


    # Compile and install SbgatGui
    Dir.chdir("SbgatGui") do
      system "ls"
      
      if build.with? "gcc"
        system "cmake . -DBREW:BOOL=TRUE -DUSE_GCC:BOOL=TRUE" 
      else
        system "cmake . -DBREW:BOOL=TRUE" 
      end 
      system "make -j"

      bin.install "SbgatGui"

    end



  end

end
