<xsl:stylesheet version="2.0"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:foldl-func="f:foldl-func"
 exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="../f/foldl.xsl"/>
   
   <xsl:output  omit-xml-declaration="yes" />

   <!-- This transformation must be applied to:
        stocks.xml 
     -->
   <foldl-func:foldl-func/>
   <xsl:variable name="vFoldlFun" 
                 select="document('')/*/foldl-func:*[1]"/>
                 
    <xsl:variable name="vTolerance" select="1"/>
        
    <xsl:template match="/">

      <xsl:call-template name="foldl">
        <xsl:with-param name="pFunc" select="$vFoldlFun"/>
        <xsl:with-param name="pList" select="/*/stock[position() > 1]"/>
        <xsl:with-param name="pA0" select="/*/stock[1]"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="foldl-func:*" mode="f:FXSL">
      <xsl:param name="arg1" select="/.."/> <!-- pA0 (accumulator) -->
      <xsl:param name="arg2" select="/.."/>
      
      <xsl:variable name="vLastPrice" select="$arg1[last()]/price"/>
      <xsl:variable name="vCurPrice" select="$arg2/price"/>
      
      <xsl:variable name="vChange" 
                    select="$arg1[last()]/price - $arg2/price"/>
       
      <xsl:copy-of select="$arg1"/>
      
      <xsl:if test="$vChange >= $vTolerance
                   or
                    $vChange &lt;= -$vTolerance" >
        <xsl:copy-of select="$arg2"/>
      </xsl:if>  
    </xsl:template>

</xsl:stylesheet>
