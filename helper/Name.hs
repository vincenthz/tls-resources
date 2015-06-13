module Main where

import Control.Monad
import System.Environment

data Type = Main | Extension | Deprecated | Obsolete [Int] | Related

data RFC = RFC
    { number  :: Int
    , name    :: String
    , authors :: String
    , date    :: String
    , extra   :: String
    } deriving (Show,Eq)

rfc :: Int -> String -> String -> String -> String -> RFC
rfc = RFC

rfcs =
    [ rfc 2246 "The TLS Protocol Version 1.0" "T. Dierks, C. Allen" "January 1999" "Obsoleted by 4346, Updated by 3546, 5746, 6176, 7465, 7507, Errata"
    , rfc 2712 "Addition of Kerberos Cipher Suites to Transport Layer Security (TLS)" "A. Medvinsky, M. Hur" "October 1999" ""
    , rfc 3268 "Advanced Encryption Standard (AES) Ciphersuites for Transport Layer Security (TLS)" "P. Chown" "June 2002" "Obsoleted by 5246"
    , rfc 3546 "Transport Layer Security (TLS) Extensions" "S. Blake-Wilson, M. Nystrom, D. Hopwood, J. Mikkelsen, T. Wright" "June 2003" "Obsoleted by 4366, Updates 2246 Proposed Standard"
    , rfc 3734 "Extensible Provisioning Protocol (EPP) Transport Over TCP" "S. Hollenbeck" "March 2004" "Obsoleted by 4934"
    , rfc 3749 "Transport Layer Security Protocol Compression Methods" "S. Hollenbeck" "May 2004" ""
    , rfc 4132 "Addition of Camellia Cipher Suites to Transport Layer Security (TLS)" "S. Moriai, A. Kato, M. Kanda" "July 2005" "Obsoleted by 5932"
    , rfc 4162 "Addition of SEED Cipher Suites to Transport Layer Security (TLS)" "H.J. Lee, J.H. Yoon, J.I. Lee" "August 2005" ""
    , rfc 4279 "Pre-Shared Key Ciphersuites for Transport Layer Security (TLS)" "P. Eronen, Ed., H. Tschofenig, Ed." "December 2005" ""
    , rfc 4346 "The Transport Layer Security (TLS) Protocol Version 1.1" "T. Dierks, E. Rescorla" "April 2006" "Obsoletes 2246, Obsoleted by 5246, Updated by 4366, 4680, 4681, 5746, 6176, 7465, 7507, Errata"
    , rfc 4347 "Datagram Transport Layer Security" "E. Rescorla, N. Modadugu" "April 2006" "Obsoleted by 6347, Updated by 5746, 7507, Errata"
    , rfc 4366 "Transport Layer Security (TLS) Extensions" "S. Blake-Wilson, M. Nystrom, D. Hopwood, J. Mikkelsen, T. Wright" "April 2006" "Obsoletes 3546, Obsoleted by 5246, 6066, Updates 4346, Updated by 5746, Errata"
    , rfc 4492 "Elliptic Curve Cryptography (ECC) Cipher Suites for Transport Layer Security (TLS)" "S. Blake-Wilson, N. Bolyard, V. Gupta, C. Hawk, B. Moeller" "May 2006" "Updated by 5246, 7027, Errata"
    , rfc 4507 "Transport Layer Security (TLS) Session Resumption without Server-Side State" "J. Salowey, H. Zhou, P. Eronen, H. Tschofenig" "May 2006" "Obsoleted by 5077"
    , rfc 4680 "TLS Handshake Message for Supplemental Data" "S. Santesson" "October 2006" "Updates 4346"
    , rfc 4681 "TLS User Mapping Extension" "S. Santesson, A. Medvinsky, J. Ball" "October 2006" "Updates 4346"
    , rfc 4785 "Pre-Shared Key (PSK) Ciphersuites with NULL Encryption for Transport Layer Security (TLS)" "U. Blumenthal, P. Goel" "January 2007" ""
    , rfc 5054 "Using the Secure Remote Password (SRP) Protocol for TLS Authentication" "D. Taylor, T. Wu, N. Mavrogiannopoulos, T. Perrin" "November 2007" "Errata"
    , rfc 5077 "Transport Layer Security (TLS) Session Resumption without Server-Side State" "J. Salowey, H. Zhou, P. Eronen, H. Tschofenig" "January 2008" "Obsoletes 4507"
    , rfc 5081 "Using OpenPGP Keys for Transport Layer Security (TLS) Authentication" "N. Mavrogiannopoulos" "November 2007" "Obsoleted by 6091"
    , rfc 5114 "Additional Diffie-Hellman Groups for Use with IETF Standards" "M. Lepinski, S. Kent" "January 2008" ""
    , rfc 5238 "Datagram Transport Layer Security (DTLS) over the Datagram Congestion Control Protocol (DCCP)" "T. Phelan" "May 2008" ""
    , rfc 5246 "The Transport Layer Security (TLS) Protocol Version 1.2" "T. Dierks, E. Rescorla" "August 2008" "Obsoletes 3268, 4346, 4366, Updates 4492, Updated by 5746, 5878, 6176, 7465, 7507, Errata"
    , rfc 5288 "AES Galois Counter Mode (GCM) Cipher Suites for TLS" "J. Salowey, A. Choudhury, D. McGrew" "August 2008" ""
    , rfc 5289 "TLS Elliptic Curve Cipher Suites with SHA-256/384 and AES Galois Counter Mode (GCM)" "E. Rescorla" "August 2008" ""
    , rfc 5430 "Suite B Profile for Transport Layer Security (TLS)" "M. Salter, E. Rescorla, R. Housley" "March 2009" "Obsoleted by 6460"
    , rfc 5469 "DES and IDEA Cipher Suites for Transport Layer Security (TLS)" "P. Eronen, Ed." "February 2009" ""
    , rfc 5487 "Pre-Shared Key Cipher Suites for TLS with SHA-256/384 and AES Galois Counter Mode" "M. Badra" "March 2009" ""
    , rfc 5489 "ECDHE_PSK Cipher Suites for Transport Layer Security (TLS)" "M. Badra, I. Hajjeh" "March 2009" ""
    , rfc 5630 "The Use of the SIPS URI Scheme in the Session Initiation Protocol (SIP)" "F. Audet" "October 2009" "Updates 3261, 3608"
    , rfc 5705 "Keying Material Exporters for Transport Layer Security (TLS)" "E. Rescorla" "March 2010" ""
    , rfc 5746 "Transport Layer Security (TLS) Renegotiation Indication Extension" "E. Rescorla, M. Ray, S. Dispensa, N. Oskov" "February 2010" "Updates 5246, 4366, 4347, 4346, 2246"
    , rfc 5878 "Transport Layer Security (TLS) Authorization Extensions" "M. Brown, R. Housley" "May 2010" "Updates 5246, Errata"
    , rfc 5929 "Channel Bindings for TLS" "J. Altman, N. Williams, L. Zhu" "July 2010" ""
    , rfc 5932 "Camellia Cipher Suites for TLS" "A. Kato, M. Kanda, S. Kanno" "June 2010" "Obsoletes 4132"
    , rfc 6042 "Transport Layer Security (TLS) Authorization Using KeyNote" "A. Keromytis" "October 2010" ""
    , rfc 6066 "Transport Layer Security (TLS) Extensions: Extension Definitions" "D. Eastlake" "3rd January 2011" "Obsoletes 4366, Errata"
    , rfc 6091 "Using OpenPGP Keys for Transport Layer Security (TLS) Authentication" "N. Mavrogiannopoulos, D. Gillmor" "February 2011" "Obsoletes 5081"
    , rfc 6209 "Addition of the ARIA Cipher Suites to Transport Layer Security (TLS)" "W. Kim, J. Lee, J. Park, D. Kwon" "April 2011" ""
    , rfc 6347 "Datagram Transport Layer Security Version 1.2" "E. Rescorla, N. Modadugu" "January 2012" "Obsoletes 4347, Updated by 7507, Errata"
    , rfc 6358 "Additional Master Secret Inputs for TLS" "P. Hoffman" "January 2012" ""
    , rfc 6367 "Addition of the Camellia Cipher Suites to Transport Layer Security (TLS)" "S. Kanno, M. Kanda" "September 2011" "Errata"
    , rfc 6460 "Suite B Profile for Transport Layer Security (TLS)" "M. Salter, R. Housley" "January 2012" "Obsoletes 5430, Errata"
    , rfc 6520 "Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS) Heartbeat Extension" "R. Seggelmann, M. Tuexen, M. Williams" "February 2012" ""
    , rfc 6655 "AES-CCM Cipher Suites for Transport Layer Security (TLS)" "D. McGrew, D. Bailey" "July 2012" "Errata"
    , rfc 6961 "The Transport Layer Security (TLS) Multiple Certificate Status Request Extension" "Y. Pettersen" "June 2013" ""
    , rfc 6962 "Certificate Transparency" "B. Laurie, A. Langley, E. Kasper" "June 2013" "Errata"
    , rfc 7027 "Elliptic Curve Cryptography (ECC) Brainpool Curves for Transport Layer Security (TLS)" "J. Merkle, M. Lochter" "October 2013" "Updates 4492, Errata"
    , rfc 7250 "Using Raw Public Keys in Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)" "P. Wouters, Ed., H. Tschofenig, Ed., J. Gilmore, S. Weiler, T. Kivinen" "June 2014" ""
    , rfc 7251 "AES-CCM Elliptic Curve Cryptography (ECC) Cipher Suites for TLS" "D. McGrew, D. Bailey, M. Campagna, R. Dugal" "June 2014" ""
    , rfc 7301 "Transport Layer Security (TLS) Application-Layer Protocol Negotiation Extension" "S. Friedl, A. Popov, A. Langley, E. Stephan" "July 2014" ""
    , rfc 7366 "Encrypt-then-MAC for Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)" "P. Gutmann" "September 2014" "Errata"
    , rfc 7457 "Summarizing Known Attacks on Transport Layer Security (TLS) and Datagram TLS (DTLS)" "Y. Sheffer, R. Holz, P. Saint-Andre" "February 2015" ""
    , rfc 7465 "Prohibiting RC4 Cipher Suites" "A. Popov" "February 2015" "Updates 5246, 4346, 2246"
    , rfc 7507 "TLS Fallback Signaling Cipher Suite Value (SCSV) for Preventing Protocol Downgrade Attacks" "B. Moeller, A. Langley" "April 2015" "Updates 2246, 4346, 4347, 5246, 6347"
    , rfc 7525 "Recommendations for Secure Use of Transport Layer Security (TLS) and Datagram Transport Layer Security (DTLS)" "Y. Sheffer, R. Holz, P. Saint-Andre" "May 2015" "Errata"
    , rfc 6101 "The Secure Sockets Layer (SSL) Protocol Version 3.0" "A. Freier, P. Karlton, P. Kocher" "August 2011" ""
    ]

main = do
    args <- getArgs
    case args of
        []         -> error "prog <url|readme>"
        "url":_    -> forM_ rfcs $ \rfc ->
            putStrLn ("http://www.rfc-editor.org/rfc/rfc" ++ show (number rfc) ++ ".txt")
        "readme":_ -> forM_ rfcs $ \rfc ->
            putStrLn ("* [" ++ name rfc ++ "](http://www.rfc-editor.org/rfc/rfc" ++ show (number rfc) ++ ".txt)")
            
