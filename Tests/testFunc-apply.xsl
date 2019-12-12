<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
 <xsl:import href="../f/func-apply.xsl"/>
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
<xsl:template match="/">

	  <xsl:sequence select=
	   "f:applyAndSum(f:funTwice(), f:funFiveTimes(), 3)"
   />
    </xsl:template>
    
  <xsl:function name="f:applyAndSum">
    <xsl:param name="arg1" as="element()"/>
    <xsl:param name="arg2" as="element()"/>
    <xsl:param name="arg3"/>
    
    <xsl:sequence select=
      "f:apply($arg1,$arg3) + f:apply($arg2,$arg3)"/>
  </xsl:function>
  
  <xsl:function name="f:funTwice" as="element()">
     <f:funTwice/>
  </xsl:function>

  <xsl:function name="f:funFiveTimes" as="element()">
     <f:funFiveTimes/>
  </xsl:function>

  <xsl:template match="f:funTwice" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:sequence select ="f:funTwice($arg1)"/>
  </xsl:template>
  
  <xsl:template match="f:funFiveTimes" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:sequence select ="f:funFiveTimes($arg1)"/>
  </xsl:template>
  
  <xsl:function name="f:funTwice">
   <xsl:param name="arg1"/>
   
   <xsl:sequence select="2*$arg1"/>
  </xsl:function>
  
  <xsl:function name="f:funFiveTimes">
   <xsl:param name="arg1"/>
   
   <xsl:sequence select="5*$arg1"/>
  </xsl:function>
</xsl:stylesheet>