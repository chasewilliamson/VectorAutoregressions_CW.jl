using VectorAutoregressions, Base.Test

# comparison against http://www-personal.umich.edu/~lkilian/figure9_1_chol.zip
y = readdlm(joinpath(Pkg.dir("VectorAutoregressions"),"test","cholvar_test_data.csv"),',')

V = VAR(y, 4, true)

@test V.p == 4
@test V.Σ ≈ [
        312.524637669663 0.773643992117187 0.919341486304653
        0.773643992117187 0.0515304724687740 0.0148802276681216
        0.919341486304653 0.0148802276681216 0.557021891337960
        ]

@test V.β[:,1:4] ≈ [
        -0.680676727884458 -0.00637960178073601 0.936519611007488 1.75104737240770
        -0.0152242907833718 0.00177981748889471 0.599086054531876 0.0281955980964510
        0.436329751995733 -0.00236721376013309 -0.218737236527547 0.332361646200618
        ]

@test V.ϵ[:,1:4] ≈ [
        70.3934221013155 -0.443580106581005 4.21164200500382 1.22299717886091
        0.189207494365181 0.287694213161629 0.692414550347607 0.405418261036420
        -1.39379479232130 0.277340573620367 -0.573151724739961 -0.395501452903569
        ]

mIRFa = IRFs_a(V,4,true)

@test [mIRFa.IRF[1,1:4]'; mIRFa.IRF[4,1:4]'; mIRFa.IRF[7,1:4]'] ≈ [
        17.6783663744607 0.0192642533976305 -2.85156060358692 0.594909295963393
        0.0437621879606954 0.0591478592307352 0.113331057827868 0.109932348126692
        0.0520037579735191 -0.0341368375885218 -0.111284843056732 -0.0491881671489620
        ]

mIRFb = IRFs_b(V,4,10,true)

@test [mIRFb.IRF[1,1:4]'; mIRFb.IRF[4,1:4]'; mIRFb.IRF[7,1:4]'] ≈ [
        17.6783663744607 0.0192642533976305 -2.85156060358692 0.594909295963393
        0.0437621879606954 0.0591478592307352 0.113331057827868 0.109932348126692
        0.0520037579735191 -0.0341368375885218 -0.111284843056732 -0.0491881671489620
        ]
