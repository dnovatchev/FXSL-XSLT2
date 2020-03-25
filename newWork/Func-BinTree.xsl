<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="func-MemoryId.xsl"/>
 
 <xsl:function name="f:makeBTree" as="item()*">
   <xsl:param name="pTop" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   
   <xsl:if test="(exists($pTop))">
     <xsl:variable name="vTopElem" as="element()">
       <e indv="{$pTop}"/>
     </xsl:variable>
     
     <xsl:sequence select=
      "f:memAdd($pMem, $vTopElem)"
      />
   </xsl:if>
 </xsl:function>
 
 <xsl:function name="f:makeBTree" as="item()*">
   <xsl:param name="pTop" as="xs:integer?"/>
   <xsl:param name="pleftT" as="xs:integer?"/>
   <xsl:param name="prightT" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   <xsl:if test="(exists($pTop))">
     <xsl:variable name="vTopElem" as="element()">
       <e indv="{$pTop}">
         <xsl:if test="exists($pleftT)">
           <xsl:attribute name="il" select="$pleftT"/>
         </xsl:if>
       
         <xsl:if test="exists($prightT)">
           <xsl:attribute name="ir" select="$prightT"/>
         </xsl:if>
       </e>
     </xsl:variable>
     
     <xsl:sequence select=
      "f:memAdd($pMem, $vTopElem)"
      />
   </xsl:if>
 </xsl:function> 
 
 <xsl:function name="f:btMember" as="xs:boolean">
   <xsl:param name="pX" as="item()"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>

   <xsl:sequence select=
    "f:btMember2($pX,$pTree,$pMem,())"
   />
<!---->   
 </xsl:function>
  <xsl:function name="f:btMember2" as="xs:boolean">
   <xsl:param name="pX" as="item()"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   <xsl:param name="pCandidate" as="item()?"/>

   <xsl:sequence select=
    "if(empty($pTree))
       then $pX eq $pCandidate
       else
         for 
             $valTree in  f:memGet($pMem,$pTree),
             $vtopVal in f:memGet($pMem,$valTree/@indv)
           return
		         if($pX lt $vtopVal)
		            then f:btMember2($pX, $valTree/@il,$pMem,$pCandidate)
		            else 
		                 f:btMember2($pX, $valTree/@ir,$pMem, $vtopVal)
		              
    "
   />
<!---->   
 </xsl:function>
 
  <xsl:function name="f:btDelNode" as="item()*">
   <xsl:param name="pX" as="xs:integer"/>
   <xsl:param name="pXNode" as="item()"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   <xsl:choose>
     <xsl:when test="empty($pTree)">
        <xsl:sequence select="$pMem"/>
     </xsl:when>
     <xsl:otherwise>
       <xsl:variable name="valTree" as="element()"
          select="f:memGet($pMem,$pTree)"/>
       <xsl:variable name="vtopVal" as="element()"
          select="f:memGet($pMem,$valTree/@indv)"/>
          
       <xsl:choose>
         <xsl:when test="$pX eq xs:integer($valTree/@indv)">
           <xsl:sequence select="f:btDelTop($valTree, $pMem)"/>
         </xsl:when>
         <xsl:otherwise>
         
           <xsl:variable name="vsubTree" as="xs:string?">
             <xsl:choose>
	             <xsl:when test=
	               "$pXNode lt $vtopVal 
	               and 
	                exists($valTree/@il)">il</xsl:when>
	             
	             <xsl:when test=
	               "$pXNode gt $vtopVal 
	               and 
	                exists($valTree/@ir)">ir</xsl:when>
             </xsl:choose>
           </xsl:variable>
           
           <xsl:choose>
             <xsl:when test="not($vsubTree)">
               <xsl:sequence select="$pMem"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:variable name="vMem2" as="item()*"
                select=
                 "if($vsubTree eq 'il')
                    then 
                      f:btDelNode($pX, $pXNode, $valTree/@il,$pMem)
                    else
                      f:btDelNode($pX, $pXNode, $valTree/@ir,$pMem)
                 "
                />
                
                <xsl:choose>
                  <xsl:when test="$pMem[1] eq $vMem2[1]">
                    <xsl:sequence select="$pMem"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:variable name="vnewTop" as="element()">
                      <xsl:copy-of select="$valTree"/>
                      <xsl:attribute name="{$vsubTree}" 
                           select="$vMem2[1]"/>
                    </xsl:variable>
                    
                    <xsl:sequence select="f:memAdd($vMem2,$vnewTop)"/>
                  </xsl:otherwise>
                </xsl:choose>
             </xsl:otherwise>
           </xsl:choose>
          </xsl:otherwise>
       </xsl:choose>
     </xsl:otherwise>
   </xsl:choose>
  </xsl:function>

  <xsl:function name="f:btDelTop" as="item()*">
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
  </xsl:function>

  <xsl:function name="f:btAddSeq"  as="item()*">
   <xsl:param name="pXs" as="item()*"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   <xsl:choose>
	   <xsl:when test="not(empty($pXs))">
	     <xsl:variable name="vMem0" select="f:memAdd($pMem,$pXs[1])"/>
	     <xsl:variable name="vMem1" select=
	        "f:btAddNode($vMem0[1], $pTree, $vMem0)"/>
	     
	     <xsl:sequence select=
	       "f:btAddSeq(subsequence($pXs,2), $pTree, $vMem1)"
       />
	   </xsl:when>
	   <xsl:otherwise>
	     <xsl:sequence select="$pMem"/>
	   </xsl:otherwise>
   </xsl:choose>
  </xsl:function>


  <xsl:function name="f:btAddNode" as="item()*">
   <xsl:param name="pX" as="xs:integer"/>
   <xsl:param name="pTree" as="xs:integer?"/>
   <xsl:param name="pMem" as="item()*"/>
   
   <xsl:message>
    f:btAddNode: 
	             $pX: '<xsl:sequence select="$pX"/>'
	          $pTree: '<xsl:sequence select="$pTree"/>'
	           $pMem: '<xsl:sequence select="$pMem"/>'

   </xsl:message>
<!---->  
   <xsl:choose>
	   <xsl:when test="(empty($pTree))">
	     <xsl:variable name="vTopElem" as="element()">
	       <e indv="{$pX}"/>
	     </xsl:variable>
	     
	     <xsl:sequence select=
	      "f:memAdd($pMem, $vTopElem)"
	      />
	   </xsl:when>
	   <!-- Insert in an existing tree -->
	   <xsl:otherwise>
	     
	     <xsl:message>
	        Adding to a non-empty tree:
	         $valX   : '<xsl:sequence select="f:memGet($pMem,$pX)"/>' 
	         $valTree: '<xsl:sequence select="f:memGet($pMem,$pTree)"/>'
	         $vtopVal: '<xsl:sequence select="f:memGet($pMem,f:memGet($pMem,$pTree)/@indv)"/>'
	         $vindLTree: '<xsl:sequence select="f:memGet($pMem,$pTree)/@il"/>'
	         $vindRTree: '<xsl:sequence select="f:memGet($pMem,$pTree)/@ir"/>'
	     </xsl:message>
<!---->	     
	     
	     <xsl:variable name="valX" select="f:memGet($pMem,$pX)"/>
	     <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	     <xsl:variable name="vindTop" select="$valTree/@indv"/>
	     <xsl:variable name="vtopVal" select="f:memGet($pMem,$vindTop)"/>
	     <xsl:variable name="vindLTree" select="$valTree/@il"/>
	     <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	     <xsl:variable name="vbLessThanTop" as="xs:boolean"
	          select="$valX lt $vtopVal"/>
	     <xsl:variable name="vMem2" select=
			      "if($vbLessThanTop)
			         then f:btAddNode($pX, $vindLTree,$pMem)
			       else if($valX gt $vtopVal)
			         then f:btAddNode($pX, $vindRTree,$pMem)
			         else $pMem    
			      "
	      />
	      
	      <xsl:sequence select=
	       "if($vMem2[1] eq $pMem[1])
	          then $pMem
	          else
	            if($vbLessThanTop)
	              then 
				          f:makeBTree(
					                     $vindTop,
					                     $vMem2[1],
					                     $vindRTree,
					                     $vMem2
					                     )
					      else
			           f:makeBTree(
		                         $vindTop,
		                         $vindLTree,
			                       $vMem2[1],
			                       $vMem2
		                         )
					      
         "
	       />

	   </xsl:otherwise>
   </xsl:choose>
  </xsl:function>
  
   <xsl:function name="f:printTree" as="element()*">
    <xsl:param name="pTree" as="xs:integer?"/>
    <xsl:param name="pMem" as="item()*"/>
	     
    <xsl:if test="exists($pTree)">
	    <xsl:variable name="valTree" select="f:memGet($pMem,$pTree)"/>
	    <xsl:variable name="vtopVal" select="f:memGet($pMem,$valTree/@indv)"/>
	    <xsl:variable name="vindLTree" select="$valTree/@il"/>
	    <xsl:variable name="vindRTree" select="$valTree/@ir"/>
	    
	    <node val="{$vtopVal}">
	      <xsl:sequence select="f:printTree($vindLTree, $pMem)"/>
	      <xsl:sequence select="f:printTree($vindRTree, $pMem)"/>
	    </node>
    </xsl:if>
  </xsl:function>

</xsl:stylesheet>