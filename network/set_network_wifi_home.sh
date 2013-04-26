#!/bin/bash
echo '
#On indique tout d abord où se situe le programme (socket avec wpa_cli...)
ctrl_interface=/var/run/wpa_supplicant
 
#On protège l accès à wpa_supplicant en l attribuant à un groupe
#Le groupe peut être un identifiant (gid) ou un nom de groupe
#Par défaut le gid est à 0 pour signifier que c est le root qui protège l accès.
ctrl_interface_group=0
 
eapol_version=2
 
#On définit le mode de sélection du point d accès (AP : Access Point)
#1 : Configuration classique
#0 : Utilisé pour le protocole IEEE 802.1X (et les réseaux établis).
#2 : Associe les points d accès dans un mode sécurisé. !!!Utilisé pour le mode Ad-Hoc!!!
#    Associe le SSID (nom de votre réseau) mais pas le BSSID (n° attribué à votre carte réseau).
#    A utiliser si vous avez une clef installée sous NDIS(WRAPPER) pour utiliser pleinement votre réseau :
#     dans ce cas le block network devra comprendre les informations  key_mgmt ,  pairwise ,  group  et les variables de protocole.
ap_scan=1
 
network={
        ssid="'$1'"
 
        #psk: clef WPA (256bits)
        #   ="mon mot de passe" : entre guillemets pour un mot de passe  texte  (entre 8 et 63caractères compris)
        psk="'$2'"
 
        #proto: protocole
        #     =WPA : WPA(1) (WPA/IEEE 802.11i/D3.0)
        #     =RSN : WPA2 (IEEE 802.11i) (par défaut)
        proto=RSN WPA
 
        #key_mgmt: encryption
        #        =WPA-PSK : WPA  pre-shared key  (requièrt une clef PSK)
        #        =WPA-EAP : WPA utilisant une authentification EAP (peut utiliser un programme externe (Xsupplicant)).
        #        =IEEE8021X : IEEE 802.1X utulisant une authentification EAP et, optionnellement la génération de clefs WEP dynamiques.
        #        =NONE : Pas de WPA : clef WEP ou connexion directe.
        #        =WPA-NONE : Pour réseaux Ad-Hoc (possibilité de groupage TKIP ou CCMP(AES))
        key_mgmt=WPA-PSK WPA-EAP
 
        #pairwise: !A ne pas confondre avec le  group  qui est plus connu!
        #        =CCMP : AES (CBC-MAC : RFC 3610, IEEE 802.11i/D7.0)
        #        =TKIP : (IEEE 802.11i/D7.0)
        #        =NONE : Utilisé pour le mode ad-hoc principalement
        pairwise=CCMP TKIP
 
        #auth_alg: système d authentification du réseau
        #        =OPEN : pour WPA et WPA2
        #        =SHARED : pour WEP
        #        =LEAP : pour LEAP sur réseau EAP
        auth_alg=OPEN
}
' > wpa.config

#cp interfaces /media/fs/etc/network/interfaces
#cp wpa.config /media/fs/etc/wpa.config
