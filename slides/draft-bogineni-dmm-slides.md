% Optimized Mobile User Plane Solutions for 5G
% K. Bogineni, et al.
% IETF 102 Montreal, 14th – 20th July, 2018

## Acknowledgements
The authors would like to thank the 3GPP delegates from various companies who
participated on the Conference Calls and provided constructive feedback on the
content development.

The authors would like to thank Farooq Bari, Devaki Chandramouli, Ravi
Guntupalli, Sri Gundavelli, Peter Ashwood Smith, Satoru Matsushima, Michael
Mayer, Vina Ermagan, Fabio Maino, Albert Cabellos, Cameron Byrne, Uma Chunduri,
and Padma Pillay-Esnault for reviewing various iterations of the document
and for providing content into various sections.


## Background
- 3GPP CT4 has initiated a study item to study different mobility management protocols for potential replacement of GTP tunnels between UPFs (N9 Interface) in the 3GPP 5G system architecture of Release 16 (5G Phase 2)
- References
 3GPP TS 29.281 (V15.1.0): GPRS Tunnelling Protocol User Plane (GTPv1-U)
    - 3GPP TR 29.891 (V15.0.0): 5G System – Phase 1; CT4 Aspects
    - 3GPP TS 23.501 (V15.0.0): System Architecture for the 5G System
    - 3GPP TS 23.503 ( V15.0.0): Policy and Charging Control Framework for the 5G System, Stage 2
    - ETSI GR NGP 004 (V1.1.1): Next Generation Protocol (NGP): Evolved Architecture for mobility using Identity Oriented Networks
- Several protocol candidates in IETF: SRv6, LISP, ILA, etc
- Document being prepared in DMM WG as submission to CT4 for consideration

## 3GPP Release 15 5G NGC Architecture

<div class="columns">

<div class="column" width="40%">

\tiny
__Non-Roaming Architecture: Reference Point Representation__

~~~
         +------+ +------+     +------+
         | NSSF | | AUSF +-N13-+ UDM  |
         +------+ +------+     +------+
               \      |      /      \
                N22  N12   N8        N10
                 \    |    /          \
                 +----+----+       +-------+      +------+      +------+
     +-----------+   AMF   +- N11 -+  SMF  +- N7 -+  PCF +- N5 -+  AF  |
     |           +++-----+++       +---+---+      +--+---+      +------+
     |            ||     ||            |             |
     |            ||     |+------------|----- N15 ---+
     N1         N2|+-N14-+            N4
     |            |                    |
  +--+--+        ++-------+        +---+---+        +------+
  |  UE +-- NR --+ (R)AN  +-- N3 --+  UPF  +-- N6 --+  DN  |
  +-----+        +--------+        ++-----++        +------+
                                    |     |
                                    +--N9-+

        5G System Architecture in Reference Point Representation
~~~

\tiny

__AUSF__: Authentication Server Function

__AMF__: Access and Mobility Management Function

__DN__: Data Network (e.g.operator services,
	Internet  access or 3rd party services)

__NEF__: Network Exposure Function

__NRF__: NF Repository Function

__NSSF__: Network Slice Selection Function

</div>

<div class="column" width="40%">

\tiny
__Non-Roaming Architecture: Services Based Interfaces__

~~~
                        Service Based Interfaces
    ----+-----+-----+----+----+---------+--------+-----+----+----
        |     |     |    |    |         |        |     |    |
    +---+---+ |  +--+--+ | +--+---+  +--+--+  +--+--+  |  +----+
    | NSSF  | |  | NRF | | | AUSF |  | UDM |  | NEF |  |  | AF |
    +-------+ |  +-----+ | +------+  +-----+  +-----+  |  +----+
          +---+----+  +--+--+            +-------------+--+
          |  AMF   |  | PCF |            |      SMF       |
          +---+--+-+  +-----+            +-+-----------+--+
             N1  |                         |           |
   +-------+  |  |                         N4          N4
   | 5G UE |--+  |                         |           |
   +---+---+     N2                  +-----+-+     +---+---+      +----+
       |         |      +----N3------+  UPF  +-N9--+  UPF  +--N6--+ DN |
       |         |      |            ++----+-+     +-------+      +----+
       |         |      |             |    |
       |     +---+------+-+           +-N9-+
       +-----|    gNB     |
             +------------+

                      5G Service Based Architecture
~~~
\tiny

__PCF__: Policy Control Function

__SMF__: Session Management Function

__UDM__: Unified Data Management

__UPF__: User Plane Function

__AF__: Application Function

__UE__: User Equipment

__RAN__: (Radio) Access Network

</div>
</div>

## Roaming Architectures
- Acronymns:
   - HPLMN: 	Home Public Land Mobile Network
   - VPLMN: 	Visited PLMN
- Definitions (3GPP TS 21.905)
   - Mobility: The ability for the user to communicate whilst moving independent of location.
   - Roaming: The ability for a user to function in a serving network different from the home network.
   The serving network could be a shared network operated by two or more network operator.
- Requirements:
   - Roaming Requirements: 3GPP TS 22.011 Section 2
   - Mobility Requirements: 3GPP TS 22.278 Section 7

<div class="columns">

<div class="column" width="40%">

\tiny
~~~
                                      VPLMN      |     HPLMN
            +-----+         +-------+            |        +-------+
            | AF  |----N5---| V-PCF |-----------N24-------| H-PCF |
            +-----+         +-------+            |        +-------+
                                |                |
                               N7                |
                                |                |
                             +--+--+             |
                             | SMF |             |
                             +--+--+             |
                                |                |
      +-------+                N4                |
      | 5G UE +                 |                |
      +---+---+           +-----+--+             |
          |               |        |             |
          |   +---+-+   +-+-+    +-+-+  +----+   |
          +---| gNB |---|UPF|-N9-|UPF|--| DN |   |
              +-----+   +-+-+    +---+  +----+   |

        Roaming 5G System Architecture - Local Breakout Scenario
~~~

</div>
<div class="column" width="40%">

\tiny

~~~
                                 VPLMN   |      HPLMN
                  --------------------  N32 ----------------------------
                     |                   |               |
                     |     +-------+     |     +-------+ |      +-----+
                     |     | V-PCF |--- N24 ---| H-PCF |---N5---| AF  |
                     |     +-------+     |     +-------+ |      +-----+
                     |                   |         |     |
                     |                   |        N7     |
                     |                   |         |     |
                     |      +--+--+      |      +--+--+  |
                     +------|V-SMF|      |      |H-SMF|--+
                            +--+--+      |      +--+--+
                               |         |         |
      +-------+                |         |         |
      | 5G UE |                |         |         |
      +---+---+               N4         |         N4
          |                    |         |         |
          |     +-+---+     +--+--+      |      +--+--+      +----+
          +-----| gNB |-----| UPF |-----N9------| UPF |------| DN |
                +-----+     +--+--+      |      +-----+      +----+
           Roaming 5G System Architecture- Home Routed Scenario
~~~

</div>
</div>

## Sample Configurations for Access to Two DNs

<div class="columns">

<div class="column" width="40%">

\tiny
~~~
                           Service Based Interfaces
       ---------+------------+------------------+----------------------
                             |                  |
                          +--+--+            +--+--+
                          | SMF |            | SMF |
                          +--+--+            +--+--+
                             |                  |
      +-------+             N4                 N4
      | 5G UE |              |                  |
      +---+---+           +--+--+    +----+     +-----------+
          |           +---| UPF |----| DN |     |           |
          |           |   +-----+    +----+     |           |
          |     +-+---+-+                    +--+--+     +--+--+  +----+
          +-----|  gNB  |--------------------| UPF |--N9-| UPF |--| DN |
                +-------+                    +-----+     +-----+  +----+

Non-roaming 5G System Architecture for multiple PDU Sessions Service Based Interface
~~~

</div>
<div class="column" width="40%">

\tiny
~~~
                           Service Based Interfaces
       ---------+-----------------------+-----------------------
                                        |
                                     +--+--+
                                     | SMF |
                                     +--+--+
                                        |
      +-------+                  +------+-------+
      | 5G UE |                  |              |
      +---+---+                  N4             N4
          |     +-+---+       +--+--+        +--+--+    +----+
          +-----| gNB |-------| UPF |----N9--| UPF |----| DN |
                +-----+       +--+--+        +-----+    +----+
                                 |
                              +--+--+
                              |  DN |
                              +-----+
~~~

</div>
</div>

## Requirements

- UPF Requirements: 3GPP TS 23.501 Section 6.2.3
- N9 Requirements: 3GPP TR 29.891 Section 5.1.1

## Reference Scenarios for Evaluation

<div class="columns">

<div class="column" width="40%">

- Non-Roaming Scenarios
   - UE- Internet Connectivity (mobility cases)
   - UE-UE IP Packet Flow (mobility cases)
   - UE – 2 DNs with multiple PDU sessions
   - UE – 2 DNs single PDU session
- Roaming Scenarios
   - Local Break out
   - Home routed
</div>

<div class="column" width="40%">

- UE mobility SSC Mode 1
   - Single UPF
   - Multiple UPF
- UE Mobility SSC Mode 2
   - Single UPF
   - Multiple UPF
- UE Mobility SSC Mode 3
   - Single UPF
   - Multiple UPF

</div>
</div>

- Support for independent slices using GTP and/or other protocol will be covered. Mobility Management will be within each slice.
- Support for one UE connected to multiple slices using different mobility protocols will be described.

- Impacts to N2, N3, N4, N6, gNB, AMF and SMF

## Reviewed Approaches for Mobility Management

- Locator-based
   - Tunnelling
   - 3GPP / GTP-U
   - Packet steering
   - SRv6 (backwards-compatible)
- Loc/ID split
   - Packet steering
      - SRv6
   - Encapsulation
      - LISP, LISP-MN, ILSR
   - Address rewrite
      - ILA
- ID-based
   - Hybrid ICN

## Protocol Stacks

## Segment Routing v6

## LISP – Locator Identifier Separation Protocol

<div class="columns">

<div class="column" width="40%">

- LISP Control-Plane (RFC6833bis)
   - Supports many data planes: ILA, SRv6, VXLAN, LISP, GTP, …
   - Mature mapping control-plane (10+ years) with large deployments
   - Mobility related drafts:
      - draft-ietf-lisp-eid-anonymity
      - draft-ietf-lisp-eid-mobility
      - draft-ietf-lisp-mn
      - draft-ietf-lisp-predictive-rlocs
- LISP Data-Plane (RFC6830bis)
   - Uses dynamic tunnel encapsulation
   - Fixed headers (16 bytes) are used between outer and inner IP headers
</div>

<div class="column" width="40%">

\tiny
~~~
                                 +----+----+
         +-------------N4--------+   SMF   +--------N4-----------+
         |                       +----+----+                     |
         |                            |                          |
         |                       +----+----+                     |
         |                       | ID-LOC  |                     |
         |                       | Mapping |      ID-LOC         |
         |  +------------------->| System  |<--control-plane--+  |
         |  |                    +----+----+                  |  |
         |  V                                                 V  |
     +---+---+                                               +---+---+
--N3-+ UPF-A +<---------- N9 - ID-LOC data-plane ----------->+ UPF-B +-N6--
     +-------+                                               +-------+
~~~

</div>
</div>


## ILA – Identifier Locator Addressing

<div class="columns">

<div class="column" width="40%">

- Identifier Locator Addressing: Problem areas, Motivation, and Use Cases:  draft-herbert-ila-motivation-00
- Identifier-locator addressing for IPv6: draft-herbert-intarea-ila-00
- Identifier Locator Addressing Mapping Protocol: draft-herbert-ila-ilamp-00
- Identifier Locator Addressing for Mobile User-Plane: draft-herbert-ila-mobile-00
- Identifier groups: draft-herbert-idgroups-00
- Mobility Management Using Identifier Locator Addressing: draft-mueller-ila-mobility-02
- Use of BGP for dissemination of ILA mapping information: draft-lapukhov-bgp-ila-afi-02
</div>

<div class="column" width="40%">

</div>
</div>


## LISP Control Plane with ILA User Plane

<div class="columns">

<div class="column" width="40%">

- LISP Control-Plane (RFC6833bis)
     - Supports many data planes: ILA, SRv6, VXLAN, LISP, GTP.
     - Mature mapping control-plane (10+ years) with large deployments
     - Mobility, traffic engineering, multihoming…
- ILA Data-Plane (draft-herbert-intarea-ila)
     - Address transformation (no encapsulation)
- LISP Control-Plane with ILA Data-Plane
     - No ILA or LISP architectural changes
     - IETF draft for LISP+ILA specific details
     - draft-rodrigueznatal-ila-lisp
</div>

<div class="column" width="50%">

\tiny
~~~
                                 +----+----+
         +-------------N4--------+   SMF   +--------N4-----------+
         |                       +----+----+                     |
         |                            |                          |
         |                       +----+----+                     |
         |                       | ID-LOC  |                     |
         |                       | Mapping |      ID-LOC         |
         |               +------>| System  |<--control-plane     |
         |               |       +----+----+     |               |
         |               V                       V               |
     +---+---+      +----+----+             +----+----+      +---+---+
--N3-+ UPF-A +--N9--+ID-L Node+<--ID-LOC--->+ID-L Node+--N9--+ UPF-B +-N6--
     +-------+  GTP +----+----+ data-plane  +----+----+  GTP +-------+
~~~

</div>
</div>

## Hybrid-ICN

<div class="columns">

<div class="column" width="40%">

- draft-muscariello-intarea-hicn
- draft-auge-dmm-hicn-mobility
- draft-auge-dmm-hicn-deployment-options

</div>

<div class="column" width="40%">

\tiny
~~~
       UE            5G-AN        N3         UPF        N9   UPF    N6
       |                          |                     |            |
   +--------+                     |                     |            |
   |  App.  |--------------------------------------------------------|
   +--------+                     |                     | +--------+ |
   | IP PDU |                     |                     | | IP PDU | |
   | (hICN) |---------------------------------------------| (hICN) | |
   +--------+ +-----------------+ | +-----------------+ | |        | |
   |        | |\     relay     /| | |\     decap     /  | |        | |
   |        | | \_____________/ |-|-| \_____________/   | |        | |
   |        | |        | GTP-U  | | | GTP-U  |          | |        | |
   |        | |        +--------+ | +--------+          | |        | |
   |   5G   | |   5G   |  UDP   |-|-|  UDP   |          | |        | |
   |   AN   |-|   AN   +--------+ | +--------+          | |        | |
   |protocol| |protocol|   IP   |-|-|   IP   |          | |        | |
   | layers | | layers +--------+ | +--------+--------+ | +--------+ |
   |        | |        |   L2   |-|-|   L2   |   L2   |-|-|   L2   | |
   |        | |        +--------+ | +--------+--------+ | +--------+ |
   |        | |        |   L1   |-|-|   L1   |   L1   |-|-|   L1   | |
   +--------+ +-----------------+ | +-----------------+ | +--------+ |
                                  |                     |            |
~~~

</div>
</div>


## Network Slicing in 5G
\tiny
~~~
Locator-based                   ID-LOC split              ID-based
(GTP, SRv6-T)             (LISP, ILSR, ILA, SRv6-E)        (hICN)
 ----+-------------------------------+-----------------------+----------
     |                               |                       |
+---------------------+ +-----------------------+ +--------------------+
| +-------+  Slice #1 | | +----------+ Slice #2 | | +-------+ Slice #4 |
| | SMF   |---+   GTP | | | Mapping  +---+      | | | SMF   |---+ hICN |
| +--+----+   |       | | +---+-----++   |      | | +--+----+   |  AMM |
| N4 |        | N4    | |     |     |    |      | | N4 |        | N4   |
| +--+--+  +--+----+  | | +---+---+ | +--+----+ | | +--+--+  +--+----+ |
| | UPF |  | UPF   |  | | | LOC-A | | | LOC-B | | | | UPF |  | UPF   | |
| +-----+  +-------+  | | +-------+ | +-------+ | | +-----+  +-------+ |
+----------- ---------+ +-----------|-----------+ +--------------------+
                  |                 |       |           |          |
               +--+-+               |    +--+-+      +--+--+    +--+-+
               | DN |               |    | DN |      | MEC |    | DN |
               +----+               |    +----+      +-----+    +----+
                       +------------|------------+
                       |            |   Slice #3 |
                       |     +------+---+        |
                       |     |          |        |
                       | +---+---+    +-+-----+  |   +----+
              +-----+  | | LOC-A |    | LOC-B |  |---| DN |
              | MEC |--| +-------+    +-------+  |   +----+
              +-----+  +-------------------------+

                          Network slices in 5G
~~~

## Next Steps
- This draft aims to provide a useful comparison among different contending options. Work will continue on roaming, charging, security, scalability, etc aspects.
- We would like to encourage interested members to work with us in an accelerated pace to complete this work in accordance with the deadlines put forward by 3GPP.
- We would like to ask the DMM WG to adopt the draft and incorporate it as part of the response back to 3GPP.
    - To attach this ongoing work to a formulated response LS back to CT4 and SA2.
    - Seek cooperation from interested teams in 3GPP to work with us in further development of this draft into a useful document to 3GPP.
    - Propose joint 3GPP-IETF meetings (CT and SA2).

