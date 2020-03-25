<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="Func-BinTree.xsl"/>
 
 <xsl:template match="/">

    <xsl:variable name="vMem"
     select="f:memNew(1 to 10)"/>
     
======================
    f:memNew(1 to 10) = <xsl:sequence select="$vMem"/> 
    
    f:memRemove($vMem, 0) =  <xsl:sequence 
                 select="f:memRemove($vMem, 0)"/>
     
    
    f:memRemove($vMem, 11) =  <xsl:sequence 
                 select="f:memRemove($vMem, 11)"/>
     
    f:memRemove($vMem, 10) =  <xsl:sequence 
                 select="f:memRemove($vMem, 10)"/>
     
    
    f:memRemove($vMem, 3) =  <xsl:sequence 
                 select="f:memRemove($vMem, 3)"/>
     
    f:memRemove($vMem, 1) =  <xsl:sequence 
                 select="f:memRemove($vMem, 1)"/>
     
======================
    f:memRemoveSeq($vMem, 1,5) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,5)"/>

    f:memRemoveSeq($vMem, 1,10) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,10)"/>

    f:memRemoveSeq($vMem, 1,11) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,11)"/>

    f:memRemoveSeq($vMem, 1,9) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,9)"/>

    f:memRemoveSeq($vMem, 9,1) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 9,1)"/>

    f:memRemoveSeq($vMem, 9,2) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 9,2)"/>

    f:memRemoveSeq($vMem, 1,1) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,1)"/>

    f:memRemoveSeq($vMem, 1,0) = <xsl:sequence 
                 select="f:memRemoveSeq($vMem, 1,0)"/>

======================

    <xsl:variable name="vMem2" select="f:makeBTree(5, $vMem)"/>
    Create Tree, top=5
    <xsl:sequence select="$vMem2"/>


===================     
     Add node = 3
     <xsl:variable name="vMem3" select="f:btAddNode(3, $vMem2[1], $vMem2)"/>

     <xsl:sequence select="$vMem3"/>


===================     
     Add node=8
     <xsl:variable name="vMem4" select="f:btAddNode(8, $vMem3[1], $vMem3)"/>

     <xsl:sequence select="$vMem4"/>


===================     
     Add node=9
     <xsl:variable name="vMem5" select="f:btAddNode(9, $vMem4[1], $vMem4)"/>

     <xsl:sequence select="$vMem5"/>


===================     
     Add node=1
     <xsl:variable name="vMem6" select="f:btAddNode(1, $vMem5[1], $vMem5)"/>

     <xsl:sequence select="$vMem6"/>


===================     
     Add node=4
     <xsl:variable name="vMem7" select="f:btAddNode(4, $vMem6[1], $vMem6)"/>

     <xsl:sequence select="$vMem7"/>


===================     
     Add node=7
     <xsl:variable name="vMem8" select="f:btAddNode(7, $vMem7[1], $vMem7)"/>

     <xsl:sequence select="$vMem8"/>


===================

  <xsl:sequence select="f:printTree($vMem8[1], $vMem8)"/>     

===================     
     Add node=7
     <xsl:variable name="vMem9" select="f:btAddNode(7, $vMem8[1], $vMem8)"/>

     <xsl:sequence select="$vMem9"/>


===================

  <xsl:sequence select="f:printTree($vMem9[1], $vMem9)"/>  
  
===================
        
   f:btMember(7,$vMem9[1], $vMem9) = <xsl:sequence select=
    "f:btMember(7,$vMem9[1], $vMem9) "/>

===================
        
   f:btMember(6,$vMem9[1], $vMem9) = <xsl:sequence select=
    "f:btMember(6,$vMem9[1], $vMem9) "/>
 </xsl:template>

</xsl:stylesheet>