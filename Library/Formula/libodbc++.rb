require 'formula'

class Libodbcxx < Formula
  homepage 'http://libodbcxx.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/libodbcxx/libodbc++/0.2.5/libodbc++-0.2.5.tar.gz'
  sha1 'e59842266b981caab24a6fae1f7d48b6799420f8'

  # Two patches are included:
  # The first: Fixes a compilation error on 64bit machines:
  # http://sourceforge.net/tracker/?func=detail&aid=3590196&group_id=19075&atid=319075
  # The second: Fixes a memory corruption error on 64bit systems:
  # https://sourceforge.net/tracker/?func=detail&aid=3601361&group_id=19075&atid=319075
  patch :DATA

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end

__END__
diff --git a/src/dtconv.h b/src/dtconv.h
index b281ec5..18a04da 100644
--- a/src/dtconv.h
+++ b/src/dtconv.h
@@ -113,7 +113,7 @@ namespace odbc {
     snprintf(buf,LONG_STR_LEN,
 # endif
 # if defined(PRId64)
-             ODBCXX_STRING_PERCENT PRId64
+             "%" PRId64
 # elif ODBCXX_SIZEOF_LONG==8
              ODBCXX_STRING_CONST("%ld")
 # else
diff --git a/src/statement.cpp b/src/statement.cpp
index 809278b..e5f0e5d 100644
--- a/src/statement.cpp
+++ b/src/statement.cpp
@@ -90,7 +90,7 @@ void Statement::_unregisterResultSet(ResultSet* rs)
 //protected
 SQLUINTEGER Statement::_getUIntegerOption(SQLINTEGER optnum)
 {
-  SQLUINTEGER res;
+  SQLULEN res;
   SQLRETURN r;

 #if ODBCVER < 0x0300
