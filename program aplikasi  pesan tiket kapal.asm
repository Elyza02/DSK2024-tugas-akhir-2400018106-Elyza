.model small
.stack 100h

.data
    prompt_rute db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Pilih Rute Kapal:", 0Dh, 0Ah, "1 = Jakarta-Bali", 0Dh, 0Ah, "2 = Surabaya-Makassar", 0Dh, 0Ah, "Pilihan: $"
    prompt_kelas db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Pilih Kelas:", 0Dh, 0Ah, "1 = Ekonomi", 0Dh, 0Ah, "2 = VIP", 0Dh, 0Ah, "3 = Eksklusif", 0Dh, 0Ah, "Pilihan: $"
    prompt_usia db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Pilih Usia:", 0Dh, 0Ah, "1 = Dewasa", 0Dh, 0Ah, "2 = Anak", 0Dh, 0Ah, "Pilihan: $"
    prompt_jumlah db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Masukkan Jumlah Tiket yang Dipesan: $"
    prompt_tanggal db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Masukkan Tanggal Keberangkatan ( 01-31): $"
    invalid_input db 0Dh, 0Ah, "Input tidak valid. Silakan masukkan angka yang sesuai.", 0Dh, 0Ah, "$"
    pesan_sukses db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Pembelian Tiket Anda Telah Sukses!", 0Dh, 0Ah, "$"
    total_harga_msg db 0Dh, 0Ah, "=========================", 0Dh, 0Ah, "Total Harga: $", 0Dh, 0Ah, "$"

    harga_rute_1 db 100, 150, 200  
    harga_rute_2 db 120, 180, 220  

    harga db 0  
    total_harga dw 100  
    jumlah_tiket db 0 
    tanggal_berangkat db 0

.code
main:
    mov ax, @data
    mov ds, ax

    mov ah, 09h                                                                                 
    lea dx, prompt_rute
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, '0' 
    mov bl, al  

    mov ah, 09h
    lea dx, prompt_kelas
    int 21h
    
    mov ah, 01h
    int 21h
    sub al, '0'
    mov cl, al  

    mov ah, 09h
    lea dx, prompt_usia
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0' 
    mov dl, al  
    
    mov ah, 09h
    lea dx, prompt_jumlah
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0' 
    mov jumlah_tiket, al ; 
   
input_tanggal:
     
    mov ah, 09h
    lea dx, prompt_tanggal
    int 21h

    mov ah, 01h
    int 21h
    sub al, '0'
    mov tanggal_berangkat, al  

    
    cmp al, 31
    ja invalid_tanggal
    cmp al, 1
    jb invalid_tanggal
    jmp lanjut

invalid_tanggal:
     
    mov ah, 09h
    lea dx, invalid_input
    int 21h
    jmp input_tanggal

lanjut:
    

tampilkan_jumlah:
     
    mov ah, 09h
    lea dx, pesan_sukses
    int 21h
    
    mov ah, 09h
    lea dx, total_harga_msg
    int 21h

    mov ax, total_harga
    call print_number
     
    mov ah, 4Ch
    int 21h

print_number:
     
    mov bx, 10
    xor cx, cx   
    
convert:
    xor dx, dx
    div bx
    add dl, '0'
    push dx
    inc cx
    test ax, ax
    jnz convert 
    
print_digits:
    pop dx
    mov ah, 02h
    int 21h
    loop print_digits
    ret

end main
