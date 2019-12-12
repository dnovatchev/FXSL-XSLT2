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
           0.30102999714059275                                           
		       0.4771212548495541                                            
		       0.6020599924614446                                            
		       0.698970006449518                                             
		       0.7781512511892135                                            
		       0.8450980404251444                                            
		       0.9030899874635121                                            
		       0.9542425101683734                                            
		       1                                                             
-->

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template name="initial" match="/">

     <xsl:value-of select="f:map(f:log10(), 1 to 10)" separator="&#xA;"/>
   </xsl:template>

</xsl:stylesheet>