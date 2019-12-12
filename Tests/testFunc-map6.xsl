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
           0                                                             
           1                                                             
		       1.584962493378093                                             
		       1.9999999939549515                                            
		       2.321928090518739                                             
		       2.58496249071745                                              
		       2.807354909651913                                             
		       2.9999999868509244                                            
		       3.169924988315051                                             
		       3.3219280785926495                                            
-->

   <xsl:output  method="text"/>
   
   <xsl:template name="initial" match="/">
    <xsl:value-of select="f:map(f:log2(), 1 to 10)" separator="&#xA;"/>
   </xsl:template>
</xsl:stylesheet>