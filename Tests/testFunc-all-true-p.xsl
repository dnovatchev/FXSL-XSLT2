<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:myPredicate="myPredicate"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f myPredicate"
>
  <xsl:import href="../f/func-allTrueP.xsl"/>
 
   <!-- This transformation must be applied to:
        ../data/boolNodes2.xml 

        Expected result: Not all hold true for: (= 'x') in:
                         <a>x</a><b>x</b><c>z</c><d>x</d>
     -->

  <myPredicate:myPredicate/>
  <xsl:variable name="vPredicate" select="document('')/*/myPredicate:*[1]" />
    
  <xsl:output omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    
    <xsl:variable name="allTrueP" 
      select="f:allTrueP(/*/*/text(), $vPredicate)"/>
    
    <xsl:choose>
	    <xsl:when test="not($allTrueP)">
	      <xsl:text>Not all hold true for: </xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>All hold true for:</xsl:text>
	    </xsl:otherwise>
    </xsl:choose>
    
    <xsl:text>(= 'x') in: </xsl:text>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
  
  </xsl:template>
  
  <xsl:template name="myPredicate" match="*[namespace-uri()='myPredicate']"
   mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:sequence select="if($arg1 = 'x')
                            then true()
                            else false()"/>
  </xsl:template>
</xsl:stylesheet>
