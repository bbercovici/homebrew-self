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
  url "https://github.com/bbercovici/SBGAT/archive/2.02.4.tar.gz"
  sha256 "c742c8358b36356fe38d84e892288825cd2016c2260d731cd284f080e1280746"
    
  depends_on "cmake"
  depends_on "qt"
  depends_on "sbgat-core"



  def install

    # Compile and install SbgatGui
    Dir.chdir("SbgatGui/build") do
      
      system "cmake .. -DBREW:BOOL=TRUE" 
      system "make -j"

      bin.install "SbgatGui"

    end



  end

end
