use std::ffi::{c_char, c_int, CString};
use std::ptr;
use net::get_net_dev_stats;
use serde::{Deserialize, Serialize};

pub mod net;


#[derive(Debug, Serialize, Deserialize)]
pub struct NetDevStat{
    dev_id: String,
    rx_bytes: u32,
    tx_bytes: u32,
    data_valid: u32,
}

impl NetDevStat {
    pub fn new() -> Self{
        let dev_id = String::from("123");
        // let dev_id_ptr = dev_id.as_ptr();
        // unsafe {
            Self {
                dev_id,
                rx_bytes: 1,
                tx_bytes: 1,
                data_valid: 1,
            }
        // }

    }
}

#[no_mangle]
pub extern "C" fn get_net_stat() -> *const c_char {
    // let stats = get_net_dev_stats();
    //
    let mut  dev_stats: Vec<NetDevStat> = Vec::new();
    //
    // // Check if the `stats` is valid (not an error)
    // match stats {
    //     Ok(stats_map) => {
    //         // Convert the stats to a C string format and return the pointer
    //         // convert_stats_to_c(stats_map)
    //         println!("stats_map: {:?}", stats_map);
    //     }
    //     Err(err) => {
    //         // On error, return a null pointer
    //         // ptr::null_mut()
    //         println!("err: {:?}", err);
    //     }

    // }

    // unsafe {
    //     let v1 = ;
        dev_stats.push(NetDevStat::new());
        dev_stats.push(NetDevStat::new());
    // }

    // dev_stats.as_mut_ptr()
    println!("dev_stats: {:?}", dev_stats);

    let mut msgpack_data = Vec::new();
    let mut serializer = rmp_serde::Serializer::new(&mut msgpack_data)
        .with_bytes(rmp_serde::config::BytesMode::ForceAll);
    dev_stats.serialize(&mut serializer).unwrap();
    println!("msgpack_data: {:?}", msgpack_data);
    Box::into_raw(msgpack_data.into_boxed_slice()) as *const c_char
}

