<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:myPred1="f:myPred1"
 xmlns:myPred2="f:myPred2"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f myPred1 myPred2"
 >
  <xsl:import href="../f/func-someTrueP.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  <xsl:import href="../f/func-flip.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
  
   <!-- This transformation must be applied to:
        numList.xml 
     -->
     
  <myPred1:myPred1/>
  <myPred2:myPred2/>
  
  <xsl:variable name="vFunP1" select="document('')/*/myPred1:*[1]"/>
  <xsl:variable name="vFunP2" select="document('')/*/myPred2:*[1]"/>

  <xsl:template match="/">
f:map(f:flip(f:g-gt(),8), /*/*/xs:integer(.))
     <xsl:copy-of select=
       "f:map(f:flip(f:g-gt(),8), /*/*/xs:integer(.))" />
     
     -------------
  
f:map(f:flip(f:g-gt(),10), /*/*/xs:integer(.))
     <xsl:copy-of select=
       "f:map(f:flip(f:g-gt(),10), /*/*/xs:integer(.))" />
     -------------
  
  <xsl:sequence select="f:g-gt(/*/*[position() = 10],8)"/>
  
     Some numbers are GT 8: <xsl:text/>
     <xsl:value-of select=
     "f:someTrueP(/*/*/xs:integer(.), f:flip(f:g-gt(), xs:integer(8)))"/> 
     Some numbers are GT 10: <xsl:text/>
     <xsl:value-of select=
     "f:someTrueP(/*/*/xs:integer(.), f:flip(f:g-gt(), xs:integer(10)))"/>
  </xsl:template>
  
  <xsl:template match="myPred1:*" mode="f:FXSL">
    <xsl:param name="arg1" select="/.."/>
      <xsl:if test="$arg1 > 8">1</xsl:if>
  </xsl:template>

  <xsl:template match="myPred2:*" mode="f:FXSL">
    <xsl:param name="arg1" select="/.."/>
      <xsl:if test="$arg1 > 10">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>