<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>
 <xsl:import href="../f/func-scanl.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 
 <!-- To be run against: ..\data\testFunc-Scanl2.xml -->

 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:param name="prunQuatas" as="element()+">
  <q name="widgets" min="1" max="8"/>
  <q name="gadgets" min="9" max="13"/>
  <q name="excess" min="14" max="999999999"/>
 </xsl:param>

 <xsl:template match="/">
    <xsl:variable name="vFactories" as="element()+"
     select="/*/*"/>
     
    <xsl:variable name="vrunTotals" as="xs:double+"
     select="f:scanl(f:add(), 0, $vFactories/@capacity)"/>
    
    <xsl:variable name="vMinInSeq" as="xs:double+" select=
     "f:map(f:add(1), $vrunTotals)"
     />
   
    <xsl:variable name="vMaxInSeq" as="xs:double+" select=
     "remove($vrunTotals,1), 999999999"
     />

    <xsl:sequence select=
     "for $ind in 1 to count($vFactories)
           return
            f:breakDownElement($ind,$vFactories,
                               $vMinInSeq, $vMaxInSeq, 
                               $prunQuatas
                               )
     "
    />
 </xsl:template>
 
 <xsl:function name="f:breakDownElement" as="element()">
   <xsl:param name="pInd" as="xs:integer"/>
   <xsl:param name="pFactories" as="element()+"/>
   <xsl:param name="pMinInSeq" as="xs:double+"/>
   <xsl:param name="pMaxInSeq" as="xs:double+"/>
   <xsl:param name="prunQuatas" as="element()+"/>
   
   <xsl:variable name="pFctry" select="$pFactories[$pInd]"/>
   
   <xsl:element name="{name($pFctry)}">
     <xsl:copy-of select="$pFctry/@*"/>
     <xsl:sequence select=
     "f:breakDown($pInd, $pMinInSeq, $pMaxInSeq, $prunQuatas)"/>
   </xsl:element>
 </xsl:function>
 
 <xsl:function name="f:breakDown">
   <xsl:param name="pInd" as="xs:integer"/>
   <xsl:param name="pMinInSeq" as="xs:double+"/>
   <xsl:param name="pMaxInSeq" as="xs:double+"/>
   <xsl:param name="prunQuatas" as="element()+"/>
   
   <xsl:variable name="vMin" as="xs:double" 
     select="$pMinInSeq[$pInd]"/>
   
   <xsl:variable name="vMax" as="xs:double" 
     select="$pMaxInSeq[$pInd]"/>
   
   <xsl:for-each select=
      "$prunQuatas[not($vMin > @max or @min > $vMax)]">
      
      <xsl:attribute name="{@name}" select=
       "min(($vMax, @max)) - max(($vMin, @min)) +1"/>
   </xsl:for-each>
 </xsl:function>
</xsl:stylesheet>
