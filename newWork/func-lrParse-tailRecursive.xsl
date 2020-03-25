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
 
 <xsl:template name="f:lrParse3" as="xs:integer*">
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

   <xsl:choose>
     <xsl:when test="not($vAct2)">
       <xsl:sequence select="$vError"/>
     </xsl:when>
     <xsl:when test="$vAct2 = 'acc'">
       <xsl:sequence select="$vAccept"/>
     </xsl:when>
     <!-- Shift N -->
     
     <xsl:otherwise>
     <!-- Shift N or Reduce K -->
       <xsl:variable name="vRuleNo" as="xs:integer?" select=
            "if(starts-with($vAct2, 'r'))
               then
                  xs:integer(substring($vAct2,2))
               else ()
            "/>
       
       <xsl:sequence select=
         "if(exists($vRuleNo))
            then $vRuleNo
            else ()
         "/>
        
       <xsl:variable name="vRule" as="element()?"
        select=
          "if(exists($vRuleNo))
             then
                key('kRuleByPos',$vRuleNo,$ppTables)
             else ()
          "/>
                     
       <xsl:variable name="vredcStack" as="xs:integer*"
        select=
         "if(exists($vRule))
            then
               subsequence($pStack,1 + $vRule/@length)
            else ()
         "/>
<!--
   <xsl:message>
     Reduce:
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$vAct2"/>
     RuleNo: <xsl:sequence select="$vRuleNo"/>
     $vRule: <xsl:sequence select="$vRule"/>
     $vredcStack: <xsl:sequence select="$vredcStack"/>
   </xsl:message>
-->   
       <xsl:variable name="vNewState" as="xs:integer"
        select="if(exists($vredcStack))
                  then
			              xs:integer(
						                key('kGotoState', 
						                     concat($vredcStack[1],'NT',
						                            $vRule/@left
						                            ),
						                     $ppTables)
					                       )
					                     
					        else
					           xs:integer(substring($vAct2,2))
                 "/>
                 
       <xsl:variable name="vNewStack" as="xs:integer*" select=
         "if(exists($vredcStack))
            then 
               ($vNewState,$vredcStack)
            else
               ($vNewState, $pStack)
         "
        />
        
        <xsl:variable name="vnewInpInd" as="xs:integer" select=
             "if(exists($vredcStack))
                then $pInputInd
                else $pInputInd + 1
             "
        />
        
       <xsl:call-template name="f:lrParse3">
         <xsl:with-param name="ppTables" select="$ppTables"/>
         <xsl:with-param name="pInput" select="$pInput"/>
         <xsl:with-param name="pInputInd" select="$vnewInpInd"/>
         <xsl:with-param name="pStack" select="$vNewStack"/>
       </xsl:call-template>
     </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
 
 
 
 
 <xsl:function name="f:lrParse3" as="xs:integer*">
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

   <xsl:choose>
     <xsl:when test="not($vAct2)">
       <xsl:sequence select="$vError"/>
     </xsl:when>
     <xsl:when test="$vAct2 = 'acc'">
       <xsl:sequence select="$vAccept"/>
     </xsl:when>
     <!-- Shift N -->
     
     
     <xsl:otherwise>
     <!-- Shift N or Reduce K -->
       <xsl:variable name="vRuleNo" as="xs:integer?" select=
            "if(starts-with($vAct2, 'r'))
               then
                  xs:integer(substring($vAct2,2))
               else ()
            "/>
       
       <xsl:sequence select=
         "if(exists($vRuleNo))
            then $vRuleNo
            else ()
         "/>
        
       <xsl:variable name="vRule" as="element()?"
        select=
          "if(exists($vRuleNo))
             then
                key('kRuleByPos',$vRuleNo,$ppTables)
             else ()
          "/>
                     
       <xsl:variable name="vredcStack" as="xs:integer*"
        select=
         "if(exists($vRule))
            then
               subsequence($pStack,1 + $vRule/@length)
            else ()
         "/>
<!--
   <xsl:message>
     Reduce:
     Stack: <xsl:sequence select="$pStack"/>
     Input: <xsl:sequence select="$pInput[$pInputInd]"/>
     Action: <xsl:sequence select="$vAct2"/>
     RuleNo: <xsl:sequence select="$vRuleNo"/>
     $vRule: <xsl:sequence select="$vRule"/>
     $vredcStack: <xsl:sequence select="$vredcStack"/>
   </xsl:message>
-->   
       <xsl:variable name="vNewState" as="xs:integer"
        select="if(exists($vredcStack))
                  then
			              xs:integer(
						                key('kGotoState', 
						                     concat($vredcStack[1],'NT',
						                            $vRule/@left
						                            ),
						                     $ppTables)
					                       )
					                     
					        else
					           xs:integer(substring($vAct2,2))
                 "/>
                 
       <xsl:variable name="vNewStack" as="xs:integer*" select=
         "if(exists($vredcStack))
            then 
               ($vNewState,$vredcStack)
            else
               ($vNewState, $pStack)
         "
        />
        
        <xsl:variable name="vnewInpInd" as="xs:integer" select=
             "if(exists($vredcStack))
                then $pInputInd
                else $pInputInd + 1
             "
        />
        
       <xsl:sequence select=
       "f:lrParse3($ppTables,$pInput,$vnewInpInd,
                   $vNewStack
                   )"
       />
     </xsl:otherwise>
   </xsl:choose>
       
 </xsl:function>
 
</xsl:stylesheet>