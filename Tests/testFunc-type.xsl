<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xdt="http://www.w3.org/2005/04/xpath-datatypes"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs xdt"
 >
  <xsl:import href="../f/func-type.xsl"/>
  
  <!-- To be applied on ../data/numList.xml -->
 
  <xsl:output omit-xml-declaration="yes"/>
 
  <xsl:template match="/">
    f:apply(f:typeConstructor(11),'03'): <xsl:value-of select="f:apply(f:typeConstructor(11),'03')"/>
    f:apply(f:typeConstructor('xxx'),'03'): <xsl:value-of select="f:apply(f:typeConstructor('xxx'),'03')"/>
    f:apply(f:typeConstructor(11),'03') gt 4: <xsl:value-of select="f:apply(f:typeConstructor(11),'03') gt 4"/>
    f:type(f:apply(f:typeConstructor(11),'03')): <xsl:value-of select="f:type(f:apply(f:typeConstructor(11),'03'))"/>
    f:type(f:apply(f:typeConstructor('string'), 3)): <xsl:value-of select="f:type(f:apply(f:typeConstructor('string'),'03'))"/>
<!--  Supported only by a SA Processor -->
    xs:token('abc') : <xsl:value-of  select="f:type(xs:token('abc'))"
       use-when="system-property('xsl:is-schema-aware')='yes'"/>

    -1 : <xsl:value-of select="f:type(-1)"/>
<!--  Supported only by a SA Processor -->
    xs:negativeInteger(-1) : <xsl:value-of select="f:type(xs:negativeInteger(-1))"
       use-when="system-property('xsl:is-schema-aware')='yes'" />
    xs:nonPositiveInteger(0) : <xsl:value-of select="f:type(xs:nonPositiveInteger(0))"
       use-when="system-property('xsl:is-schema-aware')='yes'" />

    0 : <xsl:value-of select="f:type(0)"/>
    3 : <xsl:value-of select="f:type(3)"/>
    3. : <xsl:value-of select="f:type(3.)"/>
    3.0E1 : <xsl:value-of select="f:type(3.0E1)"/>
    xs:float(3) : <xsl:value-of select="f:type(xs:float(3))"/>
<!--  Supported only by a SA Processor -->
    xs:positiveInteger(3) : <xsl:value-of select="f:type(xs:positiveInteger(3))"
       use-when="system-property('xsl:is-schema-aware')='yes'" />

   '3' : <xsl:value-of select="f:type('3')"/>
   (/*/*/text())[1] : <xsl:value-of select="f:type((/*/*/text())[1])"/>
   data((/*/*/text())[1]) : <xsl:value-of select="f:type(data((/*/*/text())[1]))"/>
  </xsl:template>
</xsl:stylesheet>