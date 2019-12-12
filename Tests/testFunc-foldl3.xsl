<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:foldl-func="f:foldl-func"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="../f/func-foldl.xsl"/>
   
   <xsl:output  omit-xml-declaration="yes" />

   <!-- This transformation must be applied to:
        ../data/stocks.xml 

        Expected result: 
	<stock>
	   <time>0.0</time>
	   <price>27.50</price>
	</stock>
	<stock>
	   <time>4.0</time>
	   <price>28.50</price>
	</stock><stock>
	   <time>8.0</time>
	   <price>25.50</price>
	</stock>
     -->
   <foldl-func:foldl-func/>
   <xsl:variable name="vFoldlFun" 
                 select="document('')/*/foldl-func:*[1]"/>
                 
    <xsl:variable name="vTolerance" select="1"/>
        
    <xsl:template match="/">
      <xsl:copy-of select="f:foldl($vFoldlFun, /*/stock[1], /*/stock[position() > 1])"/>
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
