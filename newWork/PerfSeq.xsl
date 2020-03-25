<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xsl xs f"
 >
 
	<xsl:template match="/">
	  <xsl:variable name="vSeq1" as="xs:integer*"  
	       select="1 to 10000"/>
  
	  <xsl:variable name="vSeq2" as="xs:integer*"  
	       select="for $i in $vSeq1
	                        return $i+5"
       />
	  
	  <xsl:for-each select="1 to 10000">
	    <xsl:variable name="vSeq3" as="xs:integer*"
	         select="if(. mod 2 eq 0)
	                   then $vSeq1
	                   else $vSeq2
                  "/>
	    <xsl:variable name="vSeq4" as="xs:integer*"
	         select="if(. mod 2 eq 1)
	                   then $vSeq1
	                   else $vSeq2
                  "/>
	    <xsl:variable name="vSeq5" as="xs:integer*" select=
	         "insert-before($vSeq3, 1, $vSeq4)"/>
	  
		   <xsl:value-of select="count($vSeq5)"/>
	  </xsl:for-each>
	</xsl:template>
	
</xsl:stylesheet>