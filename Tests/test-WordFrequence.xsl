<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output indent="yes"/>
	<xsl:template match="/">
		<frequencies>
			<xsl:for-each-group group-by="." select="
		     for $w in tokenize(string(.), '[\s.?!,;—:\-\+()]+')[.] 
		         return lower-case($w)">
				<xsl:sort select="count(current-group())" 
				     order="descending"/>
				<w t="{current-grouping-key()}" 
				   f="{count(current-group())}"/>
			</xsl:for-each-group>
		</frequencies>
	</xsl:template>
</xsl:stylesheet>