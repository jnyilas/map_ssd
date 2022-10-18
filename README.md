# map_ssd
Map Solaris 'sd' or 'ssd' disk driver instances to a logical name and associated ZFS zpool

## Usage:
map_ssd.sh [filter]

    $ ./map_ssd.sh 

    Vendor          Size    Inst                             Logical Dev               ZPool
    NETAPP       68.72GB     sd0   c0t600A098038305661462B4F7659994661d0               tank     
    NETAPP       68.72GB     sd1   c0t600A098038305661462B4F7659994662d0               tank     
    NETAPP       68.72GB     sd2   c0t600A098038305661462B4F7659994663d0               dozer     
    NETAPP       68.72GB     sd3   c0t600A098038305661462B4F7659994664d0               dozer     
    NETAPP       68.72GB     sd4   c0t600A098038305661462B4F7659994665d0               neo     
    SEAGATE    1200.24GB     sd5                   c0t5000C500AEEAC1AAd0               rpool
    SEAGATE    1200.24GB     sd6                   c0t5000C500AEEAD3EBd0                    
    SEAGATE    1200.24GB     sd7                   c0t5000C500AEEAC9ACd0               rpool
    SEAGATE    1200.24GB     sd8                   c0t5000C500AEEAB2DDd0                    
    SUN              SUN     sd9                                  c1t0d0   
    
    
## Filters
### By Vendor
    $ ./map_ssd.sh SUN
    Vendor          Size    Inst                             Logical Dev               ZPool
    SUN              SUN     sd9                                  c1t0d0    
    
### By zpool
    $ ./map_ssd.sh tank 
    Vendor          Size    Inst                             Logical Dev               ZPool
    NETAPP       68.72GB     sd0   c0t600A098038305661462B4F7659994661d0               tank     
    NETAPP       68.72GB     sd1   c0t600A098038305661462B4F7659994662d0               tank               
            
