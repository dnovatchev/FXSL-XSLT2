<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
 >
  <xsl:import href="../f/func-Operators.xsl"/>
  <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
  <xsl:import href="../f/func-exp.xsl"/>
  <xsl:import href="../f/func-flip.xsl"/>
  <xsl:import href="../f/func-map.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
  
  <!-- To be performed on: testSort.xml -->

  <xsl:template match="/">
-------------------------------
<!--
<xsl:sequence select=
 " f:xsltSort( f:map(f:name(), f:attributes(/*/e[2])), 
               f:data()
              ) 
"/>



<xsl:sequence select=
 "f:apply(f:flip(f:string-join(),''), 
          f:xsltSort( f:map(f:name(), f:attributes(/*/e[2])), 
                      f:data()
                     ) 
          )"/>

-->
 <xsl:perform-sort select="/*/e">
   <xsl:sort select=
     "f:apply(f:flip(f:string-join(),''), 
              f:xsltSort( f:map(f:name(), f:attributes(.)),
                          f:data()
                         )
              )"/>
 </xsl:perform-sort>
 

<!--
    <xsl:sequence select=
    "f:xsltSort( /*/e, 
                 ( f:flip(f:string-join(), ''), 
                   f:flip(f:xsltSort())f:map(f:name()), f:attributes() 
                  )   
                )"/>     
-->
  </xsl:template>
</xsl:stylesheet>