<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:t="http://fxsl.sf.net/test/"
 exclude-result-prefixes="xs f t"
 >
 <xsl:import href="../f/func-curry.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-zipWith.xsl"/>
 <xsl:import href="../f/func-exp.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 
 <xsl:output omit-xml-declaration="yes"/>
 
 <xsl:template match="/">
   t:mult3(1,2,3) = <xsl:sequence select="t:mult3(1,2,3) "/>
  
====================================================

   f:map(t:mult3(5, 3), 1 to 10) = <xsl:text>&#xA;</xsl:text>
   <xsl:sequence select="f:map(t:mult3(5, 3), 1 to 10)"/>

    
====================================================
   
   f:zipWith(t:mult3(4), 1 to 10, 1 to 10) = <xsl:text>&#xA;</xsl:text>
   <xsl:sequence select="f:zipWith(t:mult3(4), 1 to 10, 1 to 10)"/>
====================================================
   
   t:powSeq(1 to 10, 2) = <xsl:text>&#xA;</xsl:text>
   <xsl:sequence select="t:powSeq(1 to 10, 2)"/>

 </xsl:template>
 
 <t:mult3/>
 <xsl:function name="t:mult3" as="node()">
   <xsl:sequence select="document('')/*/t:mult3[1]"/>
 </xsl:function>
 
 <xsl:function name="t:mult3" as="xs:integer">
  <xsl:param name="arg1" as="xs:integer"/>
  <xsl:param name="arg2" as="xs:integer"/>
  <xsl:param name="arg3" as="xs:integer"/>
  
  <xsl:sequence select="$arg1 * $arg2 * $arg3"/>
 </xsl:function>

 <xsl:function name="t:mult3" as="node()">
  <xsl:param name="arg1" as="xs:integer"/>
  
  <xsl:sequence select="f:curry(t:mult3(), 3, $arg1)"/>
 </xsl:function>
 
 <xsl:function name="t:mult3" as="node()">
  <xsl:param name="arg1" as="xs:integer"/>
  <xsl:param name="arg2" as="xs:integer"/>
  
  <xsl:sequence select="f:curry(t:mult3(), 3, $arg1, $arg2)"/>
 </xsl:function>
 
 <xsl:template match="t:mult3" mode="f:FXSL">
  <xsl:param name="arg1" as="xs:integer"/>
  <xsl:param name="arg2" as="xs:integer"/>
  <xsl:param name="arg3" as="xs:integer"/>

  <xsl:sequence select="t:mult3($arg1,$arg2,$arg3)"/>
 </xsl:template>
 
<t:powSeq/>
 <xsl:function name="t:powSeq" as="node()">
   <xsl:sequence select="document('')/*/t:powSeq[1]"/>
 </xsl:function>
 
 <xsl:function name="t:powSeq" as="node()">
  <xsl:param name="arg1" as="xs:double*"/>
   
   <xsl:sequence select="f:curry(t:powSeq(), 2, $arg1)"/>
 </xsl:function>
 
 <xsl:function name="t:powSeq" as="xs:double*">
  <xsl:param name="arg1" as="xs:double*"/>
  <xsl:param name="arg2" as="xs:integer"/>
  
  <xsl:sequence select="f:map(f:flip(f:pow(), $arg2), $arg1)"/>
 </xsl:function>
 
 <xsl:template match="t:powSeq" mode="f:FXSL">
  <xsl:param name="arg1" as="xs:double*"/>
  <xsl:param name="arg2" as="xs:integer"/>
  
  <xsl:message>
  $arg1 = <xsl:sequence select="$arg1"/>
  $arg2 = <xsl:sequence select="$arg2"/>
  </xsl:message> 
  
  <xsl:sequence select="t:powSeq($arg1, $arg2)"/> 
 </xsl:template>
 </xsl:stylesheet>