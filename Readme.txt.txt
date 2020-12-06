FXSL for XSLT 2.0  (version 1.1)
================================

17 Dec. 2004

This is a maintenance release. One major bug has been systematically fixed within all stylesheet modules.

This affects the way in which template references should be declared. 

Any template, a reference node to which will be passed as a parameter to an FXSL xsl:function or xsl:template, now must have the 

      mode="f:FXSL"

attribute, where the prefix "f" is associated to the FXSL namespace-uri:

      xmlns:f="http://fxsl.sf.net/"

      

Example:

<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:foldl-func="foldl-func"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="func-foldl.xsl"/>

   <!-- This transformation must be applied to:
        numList.xml 
     -->
   <foldl-func:foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:value-of select="f:foldl($vFoldlFun, 1, 1 to 10 )"/>
    </xsl:template>
    
    <xsl:template match="*[namespace-uri() = 'foldl-func']"
     mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="$arg1 * $arg2"/>
    </xsl:template>

</xsl:stylesheet>


Using unique mode is necessary to ensure that no other template will be selected for processing (note that the FXSL stylesheet modules are imported into unknown user's code).


Cheers,
Dimitre Novatchev.