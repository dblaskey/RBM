!
PROGRAM RBM10_mizu
    !
    !     Dynamic river basin model for simulating water quality in
    !     branching river systems with freely-flowing river segments.
    !
    !     This version uses Reverse Particle Tracking in the Lagrangian
    !     mode and Lagrangian interpolation in the Eulerian mode.
    !
    !     This version of the model software has the following limited features:
    !
    !     1. Hydrologic and meteorologic forcings are from a direct access file
    !        prepared by the routing program.  Hydraulic parameters are estimated
    !        by the routing program using Leopold relationships describing depth
    !        and speed as a function of flow.
    !
    !     2. Output is written to Unit 20 (specified in the command line for executing
    !        RBM) and includes the simulated temperatures for the first computational cell
    !        in each segment in the same order as that of the *.network file and at the
    !        same time step.
    !
    !     Topology and routing is set up to be consistent with output
    !     from the Variable Infiltration Capacity (VIC) model developed by the
    !     Land Surface Hydrology Group at the University of Washington.
    !     Model details are described in
    !
    !     Yearsley, J. (2012), A grid-based approach for simulating stream temperature,
    !     Water Resour. Res., 48, W03506, doi:10.1029/2011WR011515
    !
    !     For additional information contact:
    !
    !     John Yearsley
    !     Land Surface Hydrology Group
    !     Dept. of Civil and Environmental Engineering
    !     Box 352700
    !     University of Washington
    !     Seattle, Washington
    !     98195-2700
    !
    !use BGIN
    !use SYSTM
    !
    implicit none
    !
    !
    character (len=200 ):: inPrefix
    character (len=200 ):: outPrefix
    character (len=200 ):: flowPrefix
    character (len=200 ):: heatPrefix
    character (len=200 ):: net_file
    character (len=200 ):: param_file
    character (len=200 ):: res_file
    character (len=200 ):: spatial_file
    character (len=200 ):: reservoir_file
    character (len=200 ):: reservoir_storage_file
    character (len=200 ):: reservoir_sel_withdraw_file
    character (len=8)   :: start_data,end_data
    integer iargc
    integer numarg
    !
    ! Command line input
    !
    numarg = iargc ( )
    if (numarg .lt. 2) then
        write (*,*) 'Too few arguments were given'
        write (*,*) ' '
        write (*,*) 'First:  Location and prefix of input files'
        write (*,*) '        (networkfile and parameterfile)'
        write (*,*) 'Second: Location and prefix of output files'
        write (*,*) ' '
        write (*,*) 'eg: $ <program-name> ./input/Salmon_0.50 ./output/Salmon_Test'
        write (*,*) ' '
        stop
    end if
    call getarg ( 1, inPrefix )
    call getarg ( 2, outPrefix )
    !
    ! Identify input/output files
    !
    net_file      = TRIM(inPrefix)//'_Network'
    param_file    = TRIM(inPrefix)//'_Parameters'
    spatial_file  = TRIM(outPrefix)//'.Spat'
    !temp_file     = TRIM(outPrefix)//'.Temp'
    res_file      = TRIM(outPrefix)//'.Resv'
    !
    write(*,*) 'Network file    : ',net_file
    write(*,*) 'Parameter file  : ',param_file!
    !write(*,*) 'Temperature file: ',temp_file
    write(*,*) 'Spatial file: ',spatial_file
    write(*,*) 'Reservoir file:   ',res_file
    !
    OPEN(UNIT=90,FILE=TRIM(net_file),STATUS='OLD')
    !
    !     Read header information from control file
    !
    read(90,*)
    read(90,'(A)') flowPrefix
    read(90,'(A)') heatPrefix
    read(90,'(A)') reservoir_file
    !
    !     Open file with reservoir parameters
    !
    open(unit=37,FILE=TRIM(reservoir_file), ACCESS='SEQUENTIAL',FORM='FORMATTED', STATUS='old')
    !
    read(90,'(A)') reservoir_storage_file
    !
    !     Open file with reservoir storage data
    !
    open(unit=38,FILE=TRIM(reservoir_storage_file),ACCESS='SEQUENTIAL',FORM='FORMATTED', STATUS='old')
    !
    read(90,'(A)') reservoir_sel_withdraw_file
    !
    !     Open file with reservoir selective withdrawal data
    !
    open(unit=39,FILE=TRIM(reservoir_sel_withdraw_file),ACCESS='SEQUENTIAL',FORM='FORMATTED', STATUS='old')
    !
    !     Call systems programs to get started
    !
    !     SUBROUTINE BEGIN reads control file, sets up topology and
    !     important properties of reaches
    !
    write(*,*) 'Calling BEGIN'
    !
    !     SUBROUTINE BEGIN reads in river system information from the NETWORK file
    !
    CALL BEGIN(param_file, spatial_file)
    !
    !     SUBROUTINE SYSTMM performs the simulations
    !
    CALL SYSTMM(res_file,param_file,flowPrefix,heatPrefix,outPrefix) ! (WUR_WF_MvV_2011/01/05)
    !
    !     Close files after simulation is complete
    !
    write(*,*) ' Closing files after simulation'

    CLOSE(37)
    CLOSE(38)
    CLOSE(39)
    CLOSE(90)
    STOP
END PROGRAM RBM10_mizu