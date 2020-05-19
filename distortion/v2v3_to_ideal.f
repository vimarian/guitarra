c
c----------------------------------------------------------------------
c
c     Convert V2V3 to Ideal. The coefficients are cos/sin of angles
c     used in expressions of JWST-STScI-001550, SM-12, section 4.3
c     2020-04-14
c
      subroutine v2v3_to_idl(x_ideal, y_ideal, v2, v3,
     &     v2_offset, v3_offset,v_idl_parity, v3_idl_yang, 
     &     precise, verbose)
      implicit none
      integer v_idl_parity, precise, verbose
      double precision xx, yy, x_ideal, y_ideal, v2, v3,
     &     v2_offset, v3_offset, v3_idl_yang
      double precision q, angle, cosa, sina, t1, t2, dv2, dv3
      q   = dacos(-1.0d0)/180.d0
      cosa = dcos(v3_idl_yang*q)
      sina = dsin(v3_idl_yang*q)
c
c     standard
c
      dv2 = v2 - v2_offset
      dv3 = v3 - v3_offset

c      print *,'v2v3_to_ideal 1', xx, yy
c     more precise using spherical astronomy expressions
c
      if(precise .eq.1) then
         call v2v3_ideal_sph(v2,v3,v2_offset,v3_offset, 
     &        dv2, dv3)
      end if
      x_ideal =  v_idl_parity * (dv2 * cosa - dv3*sina)
      y_ideal =  dv2*sina + dv3 * cosa
      if(verbose.gt.1) then
         print *,'v2v3_to_idl', dv2, dv3, v2, v3
      end if
      return
      end
