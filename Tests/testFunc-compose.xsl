<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myFun1="f:myFun1"
 xmlns:myFun2="f:myFun2" 
 exclude-result-prefixes="f xs myFun1 myFun2"
>
  <xsl:import href="../f/func-compose.xsl"/>
  <xsl:import href="../f/func-compose-flist.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  
  <!-- to be applied on any xml source, or with initial template named "initial"

       Expected result:     Compose:
                            (*3).(*2) 3 =
			    18

                            Multi Compose:
			    (*3).(*2).(*3) 2 =
			    36
  -->
  
  <xsl:output method="text"/>

  <xsl:template name="initial" match="/">
  
    <xsl:variable name="vFun1" select="document('')/*/myFun1:*[1]"/>
    <xsl:variable name="vFun2" select="document('')/*/myFun2:*[1]"/>
    Compose:
    (*3).(*2) 3 = 
    <xsl:value-of select="f:compose($vFun1, $vFun2, 3)"/>
    
    Multi Compose:
    (*3).(*2).(*3) 2 = 
    <xsl:value-of select=
     "f:compose-flist((f:mult(3), f:mult(2), f:mult(3)), 2)"/>
  </xsl:template>
  
  <myFun1:myFun1/>
  <xsl:template match="myFun1:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:value-of select="3 * number($arg1)"/>
  </xsl:template>

  <myFun2:myFun2/>
  <xsl:template match="myFun2:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:value-of select="2 * number($arg1)"/>
  </xsl:template>
</xsl:stylesheet>