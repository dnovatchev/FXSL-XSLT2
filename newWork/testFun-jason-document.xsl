<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="func-json-document.xsl"/>
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:variable name="vstrParam" as="xs:string">
{
    "glossary": {
        "title": "example glossary",
		"GlossDiv": {
            "title": "S",
			"GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
					"SortAs": "SGML",
					"GlossTerm": "Standard Generalized Markup Language",
					"Acronym": "SGML",
					"Abbrev": "ISO 8879:1986",
					"GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso": ["GML", "XML"]
                    },
					"GlossSee": "markup"
                }
            }
        }
    }
}

 </xsl:variable>
 
 <xsl:template match="/">
    Result from string:
    ==================<xsl:text>&#xA;</xsl:text>
    <xsl:sequence select="f:jason-document($vstrParam)"/>
    
    Result from file:
    ==================<xsl:text>&#xA;</xsl:text>
    <xsl:sequence select="f:jason-file-document('jsonGlossary.txt')"/>

 </xsl:template>
</xsl:stylesheet>