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
           0.693147193339396                                             
		       1.0986122901916053                                            
		       1.3862943383654853                                            
		       1.6094379264023762                                            
		       1.791759475878495                                             
		       1.9459101527746465                                            
		       2.0794415381603075                                            
		       2.1972245733278077                                            
		       2.3025850846210676                                            
-->

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template name="initial" match="/">
     <xsl:value-of select="f:map(f:ln(), 1 to 10)" separator="&#xA;"/>
   </xsl:template>

</xsl:stylesheet>