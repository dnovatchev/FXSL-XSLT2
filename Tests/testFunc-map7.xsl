<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
   <xsl:import href="../f/func-map.xsl"/>
   <xsl:import href="../f/func-exp.xsl"/>

 <!--
  To be applied on any xml file, or with initial template named "initial"
                                                                         
      Expected result:                                                   
           2.0000000057740612                                            
           4.00000002487061                                              
		       8.00000007414164                                              
		       16.00000019952256                                             
		       32.000000498873234                                            
		       64.00000119779693                                             
		       128.00000279602946                                            
		       256.0000063951123                                             
		       512.0000143895008                                             
		       1024.000031977348                                             
-->

   <xsl:output  method="text"/>
   
   <xsl:template name="initial" match="/">
    <xsl:value-of select="f:map(f:pow(2), 1 to 10)" separator="&#xA;"/>
   </xsl:template>
</xsl:stylesheet>