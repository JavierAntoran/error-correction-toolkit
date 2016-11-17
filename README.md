# error-correction-toolkit
An array of systems for correcting errors introduced by noise or other issues related to non-ideal channels. The following are included:

1.Bch(n,k) encoder and decoder(hard_decision)

2.convolutional encoder and decoder (viterbi_soft decision) and table generator based on input polinomials

3.Interleaving function, blocks based on input

4.Adaptive MMSE equalizer. Requires learning phase. This works best in non noisy channels as the filter will reduce its effect to avoid amplifying noise. Can be used in adaptive or fixed coeficient mode (implemented through script instead of ready-to-go function)

5.Channel analysis scripts based on correlating outputed pn sequences

All functions should be used only to calculate performance in terms of error correction, they can not be used in real time as most of the decodiders require the full encoded message. Real time application would require suboptimal decoding of the convolutional codes and block by block interleaving. 


