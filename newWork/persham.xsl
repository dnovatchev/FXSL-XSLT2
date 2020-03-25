<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:df="urn:TMSWebServices"
 >
	<xsl:template match="/">
	  <xsl:copy-of select=
	  "/df:xtvd/df:schedules/df:schedule[@df:program='EP7079270103']"
	  />
	</xsl:template>
</xsl:stylesheet>