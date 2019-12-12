<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myTotal="f:myTotal" xmlns:myParam="f:myParam" 
 exclude-result-prefixes="f myParam myTotal"
>
  <xsl:import href="../f/scanl.xsl"/>
  <!-- to be applied on testScanl2.xml -->
  
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <myTotal:myTotal/>
  
  <myParam:myParam>
      <subtotal>0</subtotal>
      <total>0</total>
  </myParam:myParam>
  
  <xsl:template match="/">
   
    <xsl:variable name="vFun" select="document('')/*/myTotal:*[1]"/>
    <xsl:variable name="vZeros" select="document('')/*/myParam:*[1]"/>

    
    <xsl:variable name="vrtf-calcResults">
      <xsl:call-template name="scanl">
        <xsl:with-param name="pFun" select="$vFun"/>
        <xsl:with-param name="pQ0" select="$vZeros" />
        <xsl:with-param name="pList" select="/*/*"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vcalcResults" 
     select="$vrtf-calcResults/*[position() > 1]"/>
    
    <xsl:for-each select="$vcalcResults">
      <xsl:value-of select="concat(subtotal, '&#xA;')"/>
    </xsl:for-each>
    
    <xsl:value-of select="$vcalcResults[last()]/total"/>
  </xsl:template>
  
  <xsl:template match="myTotal:*" mode="f:FXSL">
    <xsl:param name="pArg1" select="/.."/>
    <xsl:param name="pArg2" select="/.."/>
    
    <xsl:variable name="vsubTotal" 
         select="number($pArg2/@count) * number($pArg2/@unitcost)"/>
    <subtotal>
      <xsl:value-of select="$vsubTotal"/>
    </subtotal>
    
    <total>
      <xsl:value-of select="number($pArg1/total) + number($vsubTotal)"/>
    </total>
  </xsl:template>
  
</xsl:stylesheet>
