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
  url "https://github.com/bbercovici/SBGAT/archive/1.12.2.tar.gz"
  sha256 "94afacd8c0f5104669e0b7562e55e26c62ad128f8eceb0267e9baed8cab645d5"
    
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
