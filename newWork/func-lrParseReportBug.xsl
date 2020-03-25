<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:output method="text"/>
 
 <xsl:key name="kActByStateSymb" match="@act" 
          use="concat(../../@number,'T', ..)"/>
 
 <xsl:key name="kRuleByPos" match="r"
          use="count(preceding-sibling::r)"/>
          
 <xsl:key name="kGotoState" match="@newState"
          use="concat(../@number,'NT',../@NT)"/>
 
 <xsl:variable name="vAccept" as="xs:integer"
               select="0"/>
  
 <xsl:variable name="vError" as="xs:integer"
               select="999999"/>
 
 <xsl:function name="f:lrParse" as="xs:integer*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   
   <xsl:variable name="vAct" as="xs:string?"
     select="key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         $pInput[$pInputInd]
                         ),
                  $ppTables
                 )[1]"
   />
   <xsl:variable name="vAct2" as="xs:string?"
     select=
      "if($vAct != '')
        then 
          $vAct
        else
          key('kActByStateSymb',
                  concat($pStack[1],'T', 
                         '.'
                         ),
                  $ppTables
          )
     "
   />

<!--
   <xsl:message>
    $vAct:  <xsl:sequence select="$vAct"/>
    $vAct2: <xsl:sequence select="$vAct2"/>
   </xsl:message>
-->   

   <xsl:sequence select=
    "f:executeAct($ppTables,$pInput,$pInputInd,
                  $pStack,$vAct2
                  )"
    />
 </xsl:function>
 
 <xsl:function name="f:executeAct" as="xs:integer*">
   <xsl:param name="ppTables" as="element()"/>
   <xsl:param name="pInput" as="xs:string*"/>
   <xsl:param name="pInputInd" as="xs:integer"/>
   <xsl:param name="pStack" as="xs:integer+"/>
   <xsl:param name="pAct" as="xs:string?"/>
   
<!--
   <xsl:message>
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$pAct"/>
   </xsl:message>
-->   
   <xsl:choose>
     <xsl:when test="not($pAct)">
       <xsl:sequence select="$vError"/>
     </xsl:when>
     <xsl:when test="$pAct = 'acc'">
       <xsl:value-of select="$vAccept"/>
     </xsl:when>
     <!-- Shift N -->
     <xsl:when test="starts-with($pAct, 's')">
       <xsl:sequence select=
       "f:lrParse($ppTables,$pInput,$pInputInd+1,
                  (xs:integer(substring($pAct,2)),
                   $pStack)
                  )"
       />
     </xsl:when>
     <!-- Reduce K -->
     <xsl:otherwise>
       <xsl:variable name="vRuleNo" as="xs:integer"
            select="xs:integer(substring($pAct,2))"/>
       
       <xsl:sequence select="$vRuleNo"/>
        
       <xsl:variable name="vRule" as="element()"
        select="key('kRuleByPos',$vRuleNo,$ppTables)"/>
                     
       <xsl:variable name="vredcStack" as="xs:integer+"
        select="subsequence($pStack,1 + $vRule/@length)"/>
<!--
   <xsl:message>
     Reduce:
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$pAct"/>
     RuleNo: <xsl:sequence select="$vRuleNo"/>
     $vRule: <xsl:sequence select="$vRule"/>
     $vredcStack: <xsl:sequence select="$vredcStack"/>
   </xsl:message>
-->   
       <xsl:variable name="vNewState" as="xs:integer"
        select="xs:integer(
		                key('kGotoState', 
		                     concat($vredcStack[1],'NT',
		                            $vRule/@left
		                            ),
		                     $ppTables)
		                        )"/>
        
       <xsl:sequence select=
       "f:lrParse($ppTables,$pInput,$pInputInd,
                  ($vNewState,$vredcStack)
                  )"
       />
     </xsl:otherwise>
   </xsl:choose>
 </xsl:function>
</xsl:stylesheet>