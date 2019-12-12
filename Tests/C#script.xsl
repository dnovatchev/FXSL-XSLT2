<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 xmlns:myScript="my:myScript"
 exclude-result-prefixes="msxsl myScript"
 >
	<xsl:output omit-xml-declaration="yes"/>
	
	<msxsl:script language="C#" implements-prefix="myScript"><![CDATA[
    public string myTime()
    {
     return DateTime.Now.ToString();
    }
  ]]></msxsl:script>
</xsl:stylesheet>