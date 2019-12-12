<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
 >
 <xsl:import href="../f/func-repeat.xsl"/>
 <xsl:import href="../f/func-zipWithDVC.xsl"/>
 <xsl:import href="../f/func-exp.xsl"/>


 <!-- To be applied on any xml file, or with initial template named "initial"
      
      Expected result: 0
                       0.6309297564945279
		       1
		       1.2618595091750548
		       1.464973524748792
		       1.630929754815849
		       1.7712437495403988
		       1.8927892611874406
		       2.000000000983534
		       2.095903273718795

 -->
 
 <xsl:output method="text" />
  
  <xsl:template name="initial" match="/">
    <xsl:value-of separator="&#xA;" select=
    "f:zipWith(f:log(), 1 to 10, f:repeat(3, 10))"/>
  </xsl:template>
</xsl:stylesheet>
