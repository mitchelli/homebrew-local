require 'formula'

class Spectrum < Formula
  homepage 'http://spectrum.im/'
  url 'https://github.com/downloads/hanzz/libtransport/spectrum-2.0.0-beta2.tar.gz'
  sha1 'f039a2467316d4e7952bae07480620285aaae22a'
  head 'https://github.com/hanzz/libtransport.git' # for some reason lua is required for the HEAD version

  depends_on 'cmake' => :build
  depends_on 'libswiften'
  depends_on 'libpurple'
  depends_on 'protobuf'
  depends_on 'libevent'
  depends_on 'log4cxx'
  depends_on 'mysql-connector-c' => :optional
  depends_on 'postgresql' => :optional

  def install
    
    args = [
            "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}",
            "-DENABLE_SKYPE=no",
            "-DENABLE_YAHOO2=no",
            "-DENABLE_SMSTOOLS3=no",
            "-DENABLE_TWITTER=no",
            "-DENABLE_DOCS=no",
            "-DENABLE_IRC=no",
            "-DCMAKE_BUILD_TYPE=Debug"]
    if not build.with? 'mysql-connector-c'
      args << "-DENABLE_MYSQL=no"
    end
    if not build.with? 'postgresql'
      args << "-DENABLE_PQXX=no"
    end
    system "cmake .", *args
    system "make"
    system "make install"
  end
end