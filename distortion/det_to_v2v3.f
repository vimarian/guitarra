c
c----------------------------------------------------------------------
c
c     Carry out the three transformations that convert 
c     detector coordinates into (V2, V3)
c
      subroutine det_to_v2v3(
     &     x_det_ref, y_det_ref,
     &     x_sci_ref, y_sci_ref,
     &     sci_to_ideal_x,sci_to_ideal_y,sci_to_ideal_degree,
     &     ideal_to_sci_x, ideal_to_sci_y,ideal_to_sci_degree,
     &     v3_sci_x_angle,v3_sci_y_angle,
     &     v3_idl_yang,v_idl_parity,
     &     det_sci_yangle,
     &     v2_ref, v3_ref,
     &     v2, v3, x_det, y_det,
     &     precise,verbose)
      
      implicit none
      integer ideal_to_sci_degree, det_sci_parity, v_idl_parity,
     &     sci_to_ideal_degree
      double precision 
     &     x_det_ref, y_det_ref,
     &     x_sci_ref, y_sci_ref,
     &     sci_to_ideal_x,sci_to_ideal_y,
     &     ideal_to_sci_x, ideal_to_sci_y,
     &     v3_sci_x_angle,v3_sci_y_angle,
     &     v3_idl_yang,
     &     det_sci_yangle
      double precision v2_ref, v3_ref
      
      integer verbose, precise

      double precision v2, v3, x_ideal, y_ideal,
     &     x_det, y_det,
     &     x_sci, y_sci

      dimension 
     &     sci_to_ideal_x(6,6), sci_to_ideal_y(6,6), 
     &     ideal_to_sci_x(6,6), ideal_to_sci_y(6,6)
c
      call det_to_sci(x_det, y_det, x_sci, y_sci, 
     &     x_det_ref, y_det_ref, x_sci_ref, y_sci_ref, 
     &     det_sci_yangle, det_sci_parity)

      call sci_to_ideal(x_sci, y_sci, x_sci_ref, y_sci_ref,
     &     x_ideal, y_ideal,  
     &     sci_to_ideal_x, sci_to_ideal_y,
     &     sci_to_ideal_degree, verbose)
c
      call idl_to_v2v3(x_ideal, y_ideal, v2, v3,
     &     v2_ref, v3_ref,
     &     v_idl_parity, v3_idl_yang, precise, verbose)

      if(verbose.gt.2) then
         print *,' det_to_v2v3:'
         print 120,x_det, y_det, x_sci, y_sci
 120     format('det -> sci ', 4(2x,f16.10))
         print 130, x_sci, y_sci, x_ideal, y_ideal
 130     format('sci -> Idl ', 4(2x,f16.10))
         print 140, x_ideal, y_ideal, v2, v3
 140     format('Idl -> V2V3', 4(2x,f16.10))
      end if
      return
      end
