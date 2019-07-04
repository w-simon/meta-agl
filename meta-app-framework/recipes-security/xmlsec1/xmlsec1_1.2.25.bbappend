# Fix SRC_URI, 1.2.25 has moved to "old" directory
SRC_URI_remove = "http://www.aleksey.com/xmlsec/download/${BP}.tar.gz"
SRC_URI =+ "http://www.aleksey.com/xmlsec/download/old/${BP}.tar.gz"
