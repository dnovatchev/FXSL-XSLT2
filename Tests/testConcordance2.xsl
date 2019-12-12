<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-binRetrieve.xsl"/>

 <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
 <xsl:template match="/">

   <xsl:variable name="vOccurences" as="element()*">
	   <xsl:perform-sort select=
	     "f:allWords(/tstmt/bookcoll/book
	                                /chapter/(.|div)
	                                     /v/text(),
	                 f:wordFreq(/tstmt/bookcoll/book
	                                     /chapter/(.|div)
	                                        /v/text()
	                            ),
	                1280
	                 )">
	      <xsl:sort select="@str"/>
	   </xsl:perform-sort>
   </xsl:variable>
	   
		<concordance>
			<xsl:for-each-group select="$vOccurences/@str" group-by=".">
			  <xsl:sort select="current-grouping-key()"/>
				<w t="{current-grouping-key()}">
				  <xsl:for-each select="current-group()">
				    <xsl:sequence select=
				    "concat(../@b,'+',../@c,'+',../@v, 
				            if(position()ne last()) then ',' else () 
				            )"/>
				  </xsl:for-each>
				</w>
			</xsl:for-each-group>
		</concordance>	   
 </xsl:template>
 
 <xsl:function name="f:allWords" as="element()*">
   <xsl:param name="pNodes" as="node()*"/>
   <xsl:param name="pUniqWrdFreq" as="item()*"/>
   <xsl:param name="pmaxFreq" as="xs:integer"/>
   
   
   <xsl:sequence select=
    "for $vNode in $pNodes,
	       $w in tokenize(string($vNode), '[\s.?!,;—:\-\+()]+')
	               [.
	               and
	                string-length(.) gt 3
	               and
	                   f:binRetrieve($pUniqWrdFreq/@t, 
                                   string(.)
                                   )
                                   /../@f/xs:integer(.)
                   le
                     $pmaxFreq
                     
                 ] 
	          return
	             f:wordInfo($vNode, $w)"
    />
 </xsl:function>
 
 <xsl:function name="f:wordInfo" as="element()">
   <xsl:param name="pNode" as="node()"/>
   <xsl:param name="pWord" as="xs:string"/>
   
   <w str="{lower-case($pWord)}" 
       b="{substring($pNode/ancestor::book[1]/bktshort,1,3)}"
       c="{count($pNode/ancestor::chapter[1]
                             /preceding-sibling::chapter)+1}"
       v="{count($pNode/ancestor-or-self::v[1]/preceding-sibling::v)+1}"/>
                             
       
 </xsl:function>
 
 <xsl:function name="f:wordFreq" as="element()*">
   <xsl:param name="pNodes" as="node()*"/>
	 
	 <xsl:for-each-group group-by="." select=
	 "for $vNode in $pNodes,
	       $w in tokenize(string($vNode), '[\s.?!,;—:\-\+()]+')[.] 
	          return
	             lower-case($w)"
	 >
		 <xsl:sort select="current-grouping-key()" />
		 <w t="{current-grouping-key()}" 
		    f="{count(current-group())}"/>
	 </xsl:for-each-group>
 </xsl:function>
</xsl:stylesheet>