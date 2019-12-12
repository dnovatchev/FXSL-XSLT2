<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:myTest="f:myTest" 
 exclude-result-prefixes="xsl myTest"
 >
 
 <xsl:import href="../f/concat.xsl"/>
 <!-- To be applied on any xml file -->
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <myTest:myTest>
   <list1>
     <el>1</el>
     <el>2</el>
   </list1>
   <list2>
     <el>4</el>
   </list2>
 </myTest:myTest>
  
  <xsl:template match="/">
    <xsl:call-template name="concat">
      <xsl:with-param name="arg1" select="document('')/*/myTest:*[1]/*"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
