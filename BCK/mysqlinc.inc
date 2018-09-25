
{$Define HAVE_COMPRESS}
{this will actually include zlib code into the executable}
{$Define _WIN_}
{this will actually enable windows winsock imports}
{.$Define HAVE_SSL}
{this will actually include openssl calls into the executable and enable ssl communication}
{NOTE: you will need libeay32.dll and ssleay32.dll for ssl to work}
