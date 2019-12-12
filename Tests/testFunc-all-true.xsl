<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
  <xsl:import href="../f/func-allTrue.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>

  <!-- This transformation must be applied to:
        ../data/boolNodes.xml 

       Expected result: falseNot all nodes contents are true in:
                        <a>1</a><b>1</b><c>0</c><d>1</d>
     -->
  
  <xsl:template match="/">
    <xsl:variable name="allTrue"
         select="f:allTrue(/*/*/text())"/>
    
    <xsl:value-of select="$allTrue"/>

    <xsl:if test="not($allTrue)">
      <xsl:text>Not </xsl:text>
    </xsl:if>
    <xsl:value-of select="'all nodes contents are true in:'"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
  </xsl:template>
</xsl:stylesheet>
