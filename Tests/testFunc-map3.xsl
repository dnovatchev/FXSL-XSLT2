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
           2.718281826198493                                             
           7.389056095384136                                             
		       20.08553691196314                                             
		       54.59815001423152                                             
		       148.4131590788366                                             
		       403.4287934673946                                             
		       1096.633158403954                                             
		       2980.957987019516                                             
		       8103.083927556128                                             
		       22026.465794790543                                            
-->

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template name="initial" match="/">
     <xsl:value-of select="f:map(f:exp(), 1 to 10)" separator="&#xA;"/>
   </xsl:template>

</xsl:stylesheet>